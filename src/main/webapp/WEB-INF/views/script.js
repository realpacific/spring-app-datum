
	<script type="text/javascript">
		const ZONE = "zone";
		const DISTRICT = "district";
		const BOTH = "both";
		
		function callController(request, location) {
			console.log(request)
			$.ajax({
				type : "GET",
				url : "http://localhost:8080/springappdatum/getCategories?query="+request,
				success : function(data) {
					//console.log(data);
					parseJSON(data, location);
				},
				error : function(e) {
					console.log("Error:" + e);
				}
			});
		}
		
		function parseJSON(unparsed, location){
			console.log("DATA: " + unparsed+ "   LOCATION = " + location )
			if(location == ZONE){
				var arrays = unparsed["zone"];
				for(var i = 0; i < arrays.length; i++){
					$('#dropdown-zone').append('<li><a href="#">'+arrays[i]+'</a></li>');
				}
			}else if(location == DISTRICT){
				var arrays = data["district"];
				for(var i = 0; i < arrays.length; i++)
					$('#dropdown-district').append('<li><a href="#">'+arrays[i]+'</a></li>');
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
