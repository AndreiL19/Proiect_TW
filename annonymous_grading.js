/* jshint esversion: 6 */


// import require from 'require';
const express = require('express');
const mysql = require('mysql');
const session = require('express-session');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const date = require('date-utils');
const { on } = require('process');
const app = express();
const router = express.Router();
const path = require('path');
const { get } = require('http');
var userId;


app.use(express.json());
app.use(morgan('short'));
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
  });

function getConnection() {
    return mysql.createConnection({
        user: "root",
        host: "localhost",
        port: 3306,
        password: "admin",
        database: "annonymousgrading"
        //insecureAuth: true
    });
}  

app.post('/register_user', (req, response) => {
    const lastName = req.body.lname;
    const firstName = req.body.fname;
    const password = req.body.password;
    const email = req.body.email;
    const username = req.body.username;
    const isStudent = req.body.student;
    const isTeacher = req.body.teacher; 

    getConnection().query("INSERT INTO users (last_name, first_name, email, username, user_password) VALUES (?, ?, ?, ?, ?)",
    [lastName, firstName, email, username, password], (err, result, fields) => {
        if (err) {
            console.log("Failed to insert a new user: " + err);
            response.sendStatus(500);
            return;
        } else {
        getConnection().query("SELECT user_id FROM users WHERE username = ?", [username], (err, result) => {
            if (err) {
                console.log("Failed to insert a new user: " + err);
                response.sendStatus(500);
                return;
            } else {
                var jay = result;
                console.log("Inserted a new user with id: " + jay[0].user_id);
                if (isStudent) {
                    getConnection().query("INSERT INTO students (user_id) VALUES (?)", [jay[0].user_id], (err, res) => {
                        if (err) {
                            console.log("Failed to insert a new student: " + err);
                            response.sendStatus(500);
                            return;
                        } else {
                            console.log("Inserted a new student.");
                            response.end();
                            return;
                        }
                    });
                } else if (isTeacher) {
                    getConnection().query("INSERT INTO teachers (user_id) VALUES (?)", [jay[0].user_id], (err, res) => {
                        if (err) {
                            console.log("Failed to insert a new teacher: " + err);
                            response.sendStatus(500);
                            return;
                        } else {
                            console.log("Inserted a new teacher.");
                            response.end();
                            return;
                        }
                    });
                }

            }
        });
        
        }
    });
    response.sendFile(__dirname + '/register.html');
});

app.post('/login_user', (request, response) => {
    const username = request.body.username;
    const password = request.body.password;
    const isStudent = request.body.student;
    if (username && password) {
        getConnection().query("SELECT * FROM users WHERE username = ? AND user_password = ?", [username, password],
        (err, results, fields) => {
            if (err) {
                console.log("Failed to load the home page! Can't select the users!");
                response.sendStatus(500);
                response.end();
            } else {
                if (results.length > 0) {
                    request.session.loggedin = true;
                    request.session.username = username;
                    userId = results[0].user_id;
                    if (isStudent) {
                        getConnection().query("SELECT * FROM students WHERE user_id = ?", [userId],
                            (err, student_response) => {
                                if (err) {
                                    console.log("Failed to find the student according to the ID!");
                                    response.status(500);
                                    response.end();
                                    } else {
                                        console.log(student_response);
                                        var jay = student_response;
                                        console.log(jay);
                                        var student_userId = jay[0].user_id;
                                        console.log(student_userId);
                                        if (student_userId) {
                                            response.redirect('/student_homepage');
                                            response.end();
                                            return;
                                        } else {
                                            console.log("The user is not a student!");
                                            response.end();
                                            return;                                       
                                        }
                                    }
                                });
                    } else {
                        console.log("E teacher!");
                        getConnection().query("SELECT * FROM teachers WHERE user_id = ?", [userId],
                            (err, teacher_response) => {
                                if (err) {
                                    console.log("Failed to find the teacher according to the ID!");
                                    response.status(500);
                                    response.end();
                                    } else {
                                        var jay2 = teacher_response;
                                        var teacher_userId = jay2[0].user_id;
                                        if (teacher_userId) {
                                            console.log("E teacher si aici!");
                                            response.redirect('/teacher_homepage');
                                            response.end();
                                            return;  
                                        } else {
                                            console.log("The user is not a teacher!"); 
                                            response.end();
                                            return;                                        
                                        }
                                    }
                                });
                    }
                   
                } else {
                    response.send("Incorect username and/or password!");
                }
            }
        });
    } else {
        response.send("Please enter username and password!");
        response.end();
    }

});

app.get('/student_homepage_dropdownlist', (request, response) => {
    var projectId;
    var studentId;
    if (request.session.loggedin) {
        getConnection().query("SELECT user_id FROM users WHERE username = ?", [request.session.username], (err, user_result) => {
            if (err) {
                console.log("Failed to select the ID of the user!" + err);
                response.sendStatus(500);
                return;
            } else {
                console.log(request.session.username);
                var json_res = user_result[0];
                console.log(json_res);
                userId = json_res.user_id;
                console.log("Id-ul user-ului dorit: " + userId);
                getConnection().query("SELECT student_id FROM students WHERE user_id = ?", [userId], (err, student_res) => {
                    console.log(student_res);
                    if (err) {
                        console.log("Failed to select the ID of the student!" + err);
                        response.sendStatus(500);
                        return;
                    } else {
                        console.log("Bag id-ul studentului intr-o variabila");
                        console.log("S-a efectuat cu succes select-ul");
                        var jas2 = student_res[0];
                        console.log(jas2);
                        studentId = jas2.student_id;
                        console.log("Id-ul studentului dorit: " + studentId);
                        getConnection().query("SELECT project_id FROM projectmember WHERE student_id = ?", [studentId], (err, project_member_response) => {
                            if (err) {
                                console.log("Failed to select the ID of the project from project member!" + err);
                                response.sendStatus(500);
                                return;
                            } else {
                                var jas3 = project_member_response[0];
                                projectId = jas3.project_id;
                                console.log("Id-ul proiectului dorit: " + projectId);
                                getConnection().query("SELECT title, project_id FROM projects WHERE project_id <> ?", [projectId], (err, diff_projects_res) => {
                                    if (err) {
                                        console.log("Error in extracting the rest of the projects! " + err);
                                        response.sendStatus(500);
                                        return;
                                    } else {
                                        console.log("Send the JSON projects.");
                                        var jayjay = diff_projects_res;
                                        console.log(jayjay);
                                        response.json(jayjay);
                                        response.sendFile(__dirname + '/student_homepage.html');
                                        response.end();
                                        return;
                                    }
                                });
                            }
                        });
                    }
                }); 
            }
        });
    } else {
        response.send("Please login to get access!");
        response.end();
    }
});

app.get('/student_homepage', (request, response) => {
    if (request.session.loggedin) {
        response.sendFile(__dirname + '/student_homepage.html');
    } else {
        response.send("Please login to get access!");
        response.end();
    }
});


app.post('/student_review', (request, response) => {
    console.log(request.body);
    const review = request.body.review;
    const project = request.body.projects;
    const tokens = project.split(' ');
    const projectId = tokens[0];
    var projectTitle = '';
    var projectCreationDate;
    var reviewDeadline;
    var reviewDeadlineDate;
    for (var i = 1; i < tokens.length; ++i) {
        projectTitle += tokens[i] + ' ';
    }
    dateString = new Date().toISOString().slice(0, 19).replace('T', ' ');
    console.log(dateString);
    getConnection().query("SELECT creation_date FROM projects WHERE project_id = ?", [projectId], (err, project_date_res) => {
        if (err) {
            console.log("Error in selecting the creation date!");
            response.sendStatus(500);
            return;
        } else {
            projectCreationDate = project_date_res[0].creation_date;
            console.log(projectCreationDate);
            reviewDeadline = projectCreationDate.setDate(projectCreationDate.getDate() + 100);
            reviewDeadlineDate = new Date(reviewDeadline).toISOString().slice(0, 19).replace('T', ' ');
            console.log(reviewDeadlineDate);
            getConnection().query("INSERT INTO projectreviews (project_id, review_value) VALUES (?, ?)", [projectId, review], (err, rows, fields) => {
                if (err) {
                    console.log("Error inserting the review! " + err);
                    response.sendStatus(500);
                    return;
                } else {
                    console.log("The review has been submitted!");
                    response.redirect('/');
                    response.end();
                    return;
                }
        
            });
        }
    });

});


app.post('/student_homepage_project_register', (request, response) => {
    const title = request.body.project_name;
    const description = request.body.project_description;
    const creation_date = request.body.project_creation_date;
    var studentId;
    var userId;
    var projectId;

    getConnection().query("INSERT INTO projects (title, description, creation_date) VALUES (?, ?, ?)", [title, description, creation_date],
    (err, pr_result, fields) => {
        if (err) {
            console.log("Failed to insert a new project!" + err);
            response.sendStatus(500);
            return;
        } else {
            console.log("You have successfully register your project!");
            getConnection().query("SELECT project_id FROM projects WHERE title = ?", [title], (err, project_result) => {
                if (err) {
                    console.log("Failed to select the ID of the project!" + err);
                    response.sendStatus(500);
                    return;
                } else {
                    var jas = project_result[0];
                    console.log(jas);
                    projectId = jas.project_id;
                    console.log("Id-ul proiectului dorit: " + projectId);
                    console.log("Username-ul celui logat: " + request.session.username);
                    getConnection().query("SELECT user_id FROM users WHERE username = ?", [request.session.username], (err, user_res) => {
                        if (err) {
                            console.log("Failed to select the ID of the user!" + err);
                            response.sendStatus(500);
                            return;
                        } else {
                            console.log(request.session.username);
                            var json_res = user_res[0];
                            console.log(json_res);
                            userId = json_res.user_id;
                            console.log("Id-ul user-ului dorit: " + userId);
                            getConnection().query("SELECT student_id FROM students WHERE user_id = ?", [userId], (err, student_res) => {
                                if (err) {
                                    console.log("Failed to select the ID of the student!" + err);
                                    response.sendStatus(500);
                                    return;
                                } else {
                                    console.log("Bag id-ul studentului intr-o variabila");
                                    console.log("S-a efectuat cu succes select-ul");
                                    var jas2 = student_res[0];
                                    console.log(jas2);
                                    studentId = jas2.student_id;
                                    console.log("Id-ul studentului dorit: " + studentId);
 
                                }
                                getConnection().query("INSERT INTO projectmember (project_id, student_id) VALUES (?, ?)", 
                                [projectId, studentId], (err, pm_result, fields) => {
                                    if (err) {
                                        console.log("Failed to insert a new project member!" + err);
                                        response.sendStatus(500);
                                        return;
                                    } else {
                                        console.log(projectId);
                                        console.log("student_id: " + studentId);
                                        console.log("You have successfully add a team member!");
                                        response.redirect('/');
                                        response.end();
                                        return;
                                    }
                                }); 
                                
                            });
                        }
                    });
                }
            });
        }
    });
});

app.get('/check_deadline', (request, response) => {
    getConnection().query("SELECT projectreviews.project_id, review_deadline, review_value FROM projectreviews INNER JOIN projects ON projectreviews.project_id = projects.project_id", (err, deadline_data) => {
        if (err) {
            console.log("Error in selecting the review deadline! " + err);
            response.sendStatus(500);
            return;
        } else {
            var deadline_list = deadline_data;
            var grades = new Map();
            var counter = new Map();
            var mins = new Map();
            var maxs = new Map();
            var dateString = new Date().toISOString().slice(0, 19).replace('T', ' ');
            console.log(dateString);
            for (var i = 0; i < deadline_list.length; i++) {
                if (deadline_list[i].review_deadline < dateString) {
                    if (!grades.has(deadline_list[i].project_id)) {
                        grades.set(deadline_list[i].project_id, 0);
                        counter.set(deadline_list[i].project_id, 0);
                        mins.set(deadline_list[i].project_id, 10000);
                        maxs.set(deadline_list[i].project_id, -10000);

                    }
                    if (mins.get(deadline_list[i].project_id) > deadline_list[i].review_value) {
                        mins.set(deadline_list[i].project_id, deadline_list[i].review_value);
                    }
                    if (maxs.get(deadline_list[i].project_id) < deadline_list[i].review_value) {
                        maxs.set(deadline_list[i].project_id, deadline_list[i].review_value);
                    }
                    grades.set(deadline_list[i].project_id, grades.get(deadline_list[i].project_id) + deadline_list[i].review_value);
                    counter.set(deadline_list[i].project_id, counter.get(deadline_list[i].project_id) + 1);
                }
            }
            for (const [key, value] of grades.entries()) {
                console.log(key, value);
                var average = (value - mins.get(key) - maxs.get(key)) / counter.get(key);
                getConnection().query("UPDATE projects SET total_grade = ? WHERE project_id = ?", [average, key], (err) => {
                    if (err) {
                        console.log("Error in updating the total grade when the deadline is over!");
                        response.sendStatus(500);
                        return;
                    } else {
                        console.log("Updated the total grade column successfully!");
                        response.sendStatus(200);
                        response.end();
                    }
                });
            }
        }
    });
});


app.post('/student_homepage_deliverable_register', (request, response) => {
    const deliverables_projects = request.body.deliverables;
    var deliverable_description = request.body.deliverable_description;
    var deliverable_video = request.body.deliverable;
    var deliverable_title = request.body.deliverable_title;
    const tokens = deliverables_projects.split(' ');
        const projectDataId = tokens[0];
        var projectDataTitle = '';
        for (var i = 1; i < tokens.length; ++i) {
            projectDataTitle += tokens[i] + ' ';
        }
        getConnection().query("SELECT creation_date FROM projects WHERE project_id = ?", [projectDataId], (err, project_date) => {
            if (err) {
                console.log("Error in selecting the creation date! " + err);
                response.sendStatus(500);
                return;
            } else {
                var projectDate = project_date[0].creation_date;
                console.log(projectDate);
                var deliverableDeadline = projectDate.setDate(projectDate.getDate() + 45);
                deliverableDeadlineDate = new Date(deliverableDeadline).toISOString().slice(0, 19).replace('T', ' ');
                console.log(deliverableDeadlineDate);
                getConnection().query("INSERT INTO deliverables (project_id, title, description, deadline) VALUES (?, ?, ?, ?)", [projectDataId, deliverable_title, deliverable_description, deliverableDeadlineDate],
                    (err, rows, fields) => {
                        if (err) {
                            console.log("Error inserting the deliverable! " + err);
                            response.sendStatus(500);
                            return;
                        } else {
                            console.log("You successfully submitted a demo! Great job!");
                            getConnection().query("SELECT deliverable_id FROM deliverables WHERE project_id = ?", [projectDataId], (err, deliverable_data) => {
                                if (err) {
                                    console.log("Error selecting the deliverable ID!");
                                    response.sendStatus(500);
                                    return;
                                } else {
                                    var deliverableID = deliverable_data[0].deliverable_id;
                                    console.log("This is the deliverable ID: " + deliverableID);
                                    getConnection().query("INSERT INTO projectdeliverables (deliverable_id) VALUES (?)", [deliverableID], (err, rows, fields) => {
                                    if (err) {
                                        console.log("Error inserting the project deliverable! " + err);
                                        response.sendStatus(500);
                                        return;
                                    } else {
                                        console.log("You successfully submitted a demo in the projectdeliverables!");
                                        if (deliverable_video !== null) {
                                            getConnection().query("INSERT INTO videos (deliverable_id, video_link, video_name) VALUES (?, ?, ?)", [deliverableID, deliverable_video, deliverable_title],
                                            (err, rows, fields) => {
                                                if (err) {
                                                    console.log("Error inserting the video! " + err);
                                                    response.sendStatus(500);
                                                    return;
                                                } else {
                                                    console.log("You successfully submitted a video for your demo! Great job!");
                                                    getConnection().query("SELECT video_id FROM videos WHERE deliverable_id = ?", [deliverableID], (err, video_data) => {
                                                        if (err) {
                                                            console.log("Error selecting the video id! " + err);
                                                            response.sendStatus(500);
                                                            return;
                                                        } else {
                                                            var videoId = video_data[0].video_id;
                                                            console.log("This is the video ID: " + videoId);
                                                            getConnection().query("UPDATE deliverables SET video_id = ? WHERE deliverable_id = ?", [videoId, deliverableID], (err) => {
                                                                if (err) {
                                                                    console.log("Error in updating the row video ID! " + err);
                                                                    response.sendStatus(500);
                                                                    return;
                                                                } else {
                                                                    console.log("The video ID column was updated successfully!");
                                                                    response.redirect('/');
                                                                    response.end();
                                                                    return;
                                                                }
                                                            });
                                                        }
                                                    });
                                                }

                                            });
                                        }
                                        // response.redirect('/');
                                        // response.end();
                                        // return;
                                    }
                                    });
                                }
                            });
                        }
                    });
            }
        });

});


app.get('/student_homepage_deliverables', (request, response) => {
    if (request.session.loggedin) {
        getConnection().query("SELECT user_id FROM users WHERE username = ?", [request.session.username], (err, user_data) => {
            if (err) {
                console.log("Error selecting the USER ID!");
                response.sendStatus(500);
                return;
            } else {
                var json_res = user_data[0];
                console.log(json_res);
                userId = json_res.user_id;
                console.log("Id-ul user-ului dorit: " + userId);
                getConnection().query("SELECT student_id FROM students WHERE user_id = ?", [userId], (err, student_res) => {
                    if (err) {
                        console.log("Failed to select the ID of the student!" + err);
                        response.sendStatus(500);
                        return;
                    } else {
                        console.log("Bag id-ul studentului intr-o variabila");
                        console.log("S-a efectuat cu succes select-ul");
                        var jas2 = student_res[0];
                        console.log(jas2);
                        studentId = jas2.student_id;
                        console.log("Id-ul studentului dorit: " + studentId);
                        getConnection().query("SELECT title, projects.project_id FROM projects LEFT JOIN projectmember ON projectmember.project_id = projects.project_id WHERE student_id = ?", [studentId], (err, project_data) => {
                                if (err) {
                                    console.log("Error selecting the project reviews!");
                                    response.sendStatus(500);
                                    return;
                                } else {
                                    var projectData = project_data;
                                    response.json(projectData);
                                    console.log(projectData);
                                    response.sendFile(__dirname + '/student_homepage.html');
                                    response.end();
                                    return;
                                }
                            });
                        }
                    });
                }
            });
    } else {
        response.send("Please login to get access!");
        response.end();
    }
});

app.get('/teacher_homepage_list', (request, response) => {
    if (request.session.loggedin) {
        getConnection().query("SELECT title, review_value, review_date, review_deadline FROM projectreviews LEFT JOIN projects ON projectreviews.project_id = projects.project_id", (err, project_reviews_res) => {
            if (err) {
                console.log("Error selecting the project reviews!");
                response.sendStatus(500);
                return;
            } else {
                var projectReviewRes = project_reviews_res;
                response.json(projectReviewRes);
                console.log(projectReviewRes);
                response.end();
                return;

            }
        });
    } else {
        response.send("Please login to get access!");
        response.end();
    }
});

app.get('/teacher_homepage', (request, response) => {
    if (request.session.loggedin) {
        response.sendFile(__dirname + '/teacher_homepage.html');
    } else {
        response.send("Please login to get access!");
        response.end();
    }
});

app.get('/home_page', (request, response) => {
    if (request.session.loggedin) {
        response.send("Welcome back, " + request.session.username + "!");
    } else {
        response.send("Please login to get access!");
    }
    response.end();
});


app.get('/user/:id', (req, res) => {
    console.log("Fetching user with id: " + req.params.id);

    const database = getConnection();

    database.connect(function(err) {
        if (err) throw err;
        console.log("Connected!");
      });

    database.query("SELECT * FROM users;", (err, rows, fields) => {
        if (err) {
            console.log("The error occured: " + err);
            res.sendStatus(500);
            res.end();
            return;
        } else {
        console.log("I think we fetched users successfully");
        res.json(rows);
        }
    });
});

app.listen('3004', () => {
    console.log("Connected via port 3004. Now listening...");
});
