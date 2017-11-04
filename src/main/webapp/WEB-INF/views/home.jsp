<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ page session="false"%>
        <html>

        <head>
            <meta charset="UTF-8">
            <!-- If IE use the latest rendering engine -->
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <!-- Set the page to the width of the device and set the zoon level -->
            <meta name="viewport" content="width = device-width, initial-scale = 1">
            <title>DATUM</title>
            <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
            <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
            <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
            <script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        </head>

        <body>
            <div class="container">
                <h1>SPRING APP DATUM</h1>
                <div class="jumbotron">
                    <div class="row">
                        <div class="col-lg-4">
                            <button class="btn-lg btn-success" id="get_zone">GET ZONE</button>
                            <br />
                            <br />
                            <div class="dropdown">
                                <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
                                    SELECT ZONE <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" id="dropdown-zone">
                                </ul>
                            </div>
                            <br>
                        </div>
                        <div class="col-lg-4">
                            <button class="btn-lg btn-success" id="get_district">GET DISTRICT
                            </button>
                            <br />
                            <br />
                            <div class="dropdown">
                                <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
                                    SELECT DISTRICT <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" id="dropdown-district">
                                </ul>
                            </div>
                            <br>
                        </div>
                        <div class="col-lg-3">
                            <button class="btn-lg btn-success" id="get_both">GET BOTH</button>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
            
            <style type="text/css">
	            body {
	                font-family: 'Josefin Sans', sans-serif;
	            }
            </style>
            
            
            <script type="text/javascript">
	            const ZONE = "zone";
	            const DISTRICT = "district";
	            const BOTH = "both";
	
	            
	            /*
	            	Ajax function to call the controller w/ request as parameter
	            	@location is used to determine which button was clicked
	            	@request holds the ajax request  
	            */
	            function callController(request, location) {
	                //console.log(request)
	                $.ajax({
	                    type: "GET",
	                    url: "http://localhost:8080/springappdatum/getCategories?query=" + request,
	                    success: function(data) {
	                        parseJSON(data, location)
	                    },
	                    error: function(e) {
	                        console.log("Error:" + e);
	                    }
	                });
	            }
	
	            /*
	            	Parses JSON depending upon the button which invoked it (@location)
	            	@location holds the button which invoked it
	            	@data holds string
	            */
	            function parseJSON(data, location) {
	                //parse string to JSON
	                my_json = JSON.parse(data)
	                //If it is invoked by "GET ZONE" button, array is certainly in "zone" variable.
	                if (location == ZONE) {
	                    //CLEAR <ul> if there was any
	                    $('#dropdown-zone').empty()
	                    var arr_zone = my_json[ZONE];
	                    //iterate
	                    for (var i = 0; i < arr_zone.length; i++) {
	                        $('#dropdown-zone').append('<li><a href="#">' + arr_zone[i] + '</a></li>');
	                    }
	                } else if (location == DISTRICT) {
	                    $('#dropdown-district').empty()
	                    var arr_district = my_json[DISTRICT];
	                    for (var i = 0; i < arr_district.length; i++) {
	                        $('#dropdown-district').append('<li><a href="#">' + arr_district[i] + '</a></li>');
	                    }
	                } else if (location == BOTH) {
	                    $('#dropdown-district').empty();
	                    $('#dropdown-zone').empty();
	                    var arr_both = my_json["result"]; //TWO ARRAYS: DISTRICT AND ZONE
	                    for (var i = 0; i < arr_both.length; i++) {
	                        if (i == 0) {
	                            //1st element in arrays is "district"
	                            var arr_inner_district = arr_both[i][DISTRICT];
	                            console.log("W " + arr_inner_district)
	                            for (var k = 0; k < arr_inner_district.length; k++) {
	                                $('#dropdown-district').append('<li><a href="#">' + arr_inner_district[k] + '</a></li>');
	                            }
	                        } else if (i == 1) {
	                            var arr_inner_zone = arr_both[i][ZONE];
	                            for (var k = 0; k < arr_inner_zone.length; k++) {
	                                $('#dropdown-zone').append('<li><a href="#">' + arr_inner_zone[k] + '</a></li>');
	                            }
	                        }
	                    }
	                }
	            }
	
	            $('#get_zone').on('click', function() {
	                var request = "{\"keyword\" : [\"zone\"]}";
	                callController(request, ZONE);
	            })
	
	            $('#get_district').on('click', function() {
	                var request = "{\"keyword\" : [\"district\"]}";
	                callController(request, DISTRICT);
	            })
	
	            $('#get_both').on('click', function() {
	                var request = "{\"keyword\" : [\"zone\", \"district\"]}";
	                callController(request, BOTH);
	            })
            </script>
        </body>

        </html>