<?php
//connects to database via object-oriented sqli. Returns connection.
function connect_to_db($db_hostname, $db_username, $db_password, $db_database)
{
	echo "<p>Connecting to database <b> $db_database</b> on host <b>
		$db_hostname</b> for user <b>$db_username</b>... ";

	$connection = new mysqli($db_hostname, $db_username, $db_password, $db_database);
	if (!$connection) {
		echo " Failure!</p>";
		die($connection->error);
		return $connection;
	}
	else {
		echo "Success!</p>";
		return $connection;
	}
}

//shows a query result as a table
function show_table ($result)
{
	if ($result->num_rows > 0) {
	    //table drawing starts here
	    echo '<br><table>';
	    //first, the headers
	    echo '<tr>';
	    while ($header = $result->fetch_field()){
	    	echo '<th>' . $header->name . '</th>';
	    }
	    echo '</tr>';
	    //second, the contents
	    while($row = $result->fetch_array(MYSQLI_NUM)) {
	        echo '<tr>';
	        foreach ($row as $value) {
	        	echo '<td>' . $value . '</td>';
	        }
	        echo '</tr>';
	    }
	    echo '</table>';
	} else {
	    echo "0 results";
	}
}

//return a student name by id
function get_name ($connection, $id){
	$sql = "SELECT FName, LName FROM Students WHERE id=\"$id\"";
	$result = $connection->query($sql);
	if (!$result) {
		echo "Could not receive query result - get_name" . '<br><br>';
		die ($connection->error);
	}
	$row = $result->fetch_array(MYSQLI_NUM);
	return "$row[0] $row[1]";
}

?>