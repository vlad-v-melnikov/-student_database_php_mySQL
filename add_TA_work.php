<!DOCTYPE html>
<html>
<head>
	<title>Add TA Course</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>

<a href=".">Back to Form Index</a>
<br>

<?php
require_once 'login.php';
require_once 'util.php';
?>

<?php
//FUNCTION connect($db_hostname, $db_username, $db_password, $db_database)
$connection = connect_to_db($db_hostname, $db_username, $db_password, $db_database);
?>

<b>Current TA workload:</b><br>

<?php
//display current TAs and their work load
$query_TAs_view = "SELECT Students.id, FName, LName, SUM(Log_of_TAs.Hours) AS Hours FROM Students, Log_of_TAs WHERE Students.id = Log_of_TAs.id_from_Students_from_Graduates_from_TAs AND Log_of_TAs.Year >= 2019 GROUP BY (Log_of_TAs.id_from_Students_from_Graduates_from_TAs)";

$result_TAs_view = $connection->query($query_TAs_view);
if (!$result_TAs_view) {
	echo "Could not receive query result - TA_view" . '<br><br>';
	die ($connection->error);
}

show_table($result_TAs_view);
?>

<br>

<?php
//these arrays should be queries from the database
//only TAs with 0 or 1 courses
$TA_sql = "SELECT id, FName, LName FROM Students WHERE id IN (SELECT id_from_Students_from_Graduates FROM TAs)";
$result_TAs = $connection->query($TA_sql);
if (!$result_TAs) {
	echo "Could not receive query result - TA fill" . '<br><br>';
	die ($connection->error);
}
//assignments
$tasks = array("Lab" => 80, "Marker" => 80, "Tutorial"=>80);
$terms = array("Fall", "Winter", "Summer");

//courses
$course_sql = "SELECT id FROM Courses";
$result_courses = $connection->query($course_sql);
if (!$result_courses) {
	echo "Could not receive query result - courses fill" . '<br><br>';
	die ($connection->error);
}
?>

<form action="add_TA_work.php" method="post">
	Select a TA: <select name="TA">
		<?php
		while ($row = $result_TAs->fetch_array(MYSQLI_NUM)) {
			echo "<option value=\"$row[0]\">$row[0] $row[1] $row[2] </option>";
		}
		?>
	</select>
	Select a course: <select name="course">
		<?php
		while ($row = $result_courses->fetch_array(MYSQLI_NUM)) {
			echo "<option value=\"$row[0]\">$row[0]</option>";
		}
		?>
	</select>
	<br><br>
	Select an assignment: <select name="task">
		<?php
		foreach ($tasks as $key => $value) {
			echo "<option value=\"$key\">$key $value hours</option>";
		}
		?>
	</select>
	Select the term and year: <select name="term">
		<?php
		foreach ($terms as $value) {
			echo "<option value=\"$value\">$value</option>";
		}
		?>
	</select>
	<input type = "number" name="year" value = "2019" min="2019">
	<br><br>

	<input type="submit" value="Select">
</form>

<br>

<?php
//process selected student
if (isset($_POST['TA']) 
	&& isset($_POST['course']) 
	&& isset($_POST['task'])) {

	$TA_id = $_POST['TA'];
	$TA_name = get_name($connection, $TA_id);
	$course = $_POST['course'];
	$task = $_POST['task'];
	$term = $_POST['term'];
	$year = $_POST['year'];

	//check for number of courses and number of work hours here
	$hoursOK = TRUE;
	$coursesOK = TRUE;
	
	//hours
	$hours_sql = "SELECT SUM(Log_of_TAs.Hours) FROM Log_of_TAs WHERE Log_of_TAs.id_from_Students_from_Graduates_from_TAs = \"$TA_id\" 
AND Year = \"$year\"";
	$result_hours = $connection->query($hours_sql);
	if (!$result_hours) {
		echo "Could not receive query result - hours for TA work" . '<br><br>';
		die ($connection->error);
	}
	$row = $result_hours->fetch_array(MYSQLI_NUM);

	$hours_sum = $row[0] + 80;
	if($hours_sum > 260) {
		$hoursOK = FALSE;
		echo "With new assignment, this TA has <b>$hours_sum, over 260</b>. TA assignment NOT added.<br>";
	}

	//courses
	$course_no_sql = "SELECT COUNT(*) FROM Log_of_TAs WHERE Year = \"$year\" AND Term = \"$term\" AND id_from_Students_from_Graduates_from_TAs = \"$TA_id\"";
	$result_course_no = $connection->query($course_no_sql);
	if (!$result_course_no) {
		echo "Could not receive query result - hours for TA work" . '<br><br>';
		die ($connection->error);
	}
	$row = $result_course_no->fetch_array(MYSQLI_NUM);

	$course_no = $row[0] + 1;
	
	if($course_no > 2) {
		$coursesOK = FALSE;
		echo "With new assignment, this TA has <b>$course_no courses, more than 2</b>. TA assignment NOT added.<br>";
	}

	//insert record into the log
	if ($hoursOK && $coursesOK) {
		$sql = "INSERT INTO Log_of_TAs VALUES (NULL, \"$task\", \"$year\", \"$term\", 80, \"$TA_id\", \"$course\")";
		$result = $connection->query($sql);
		if (!$result) {
			echo "Could not receive query result - add TA work" . '<br><br>';
			die ($connection->error);
		}
		echo "<b>$TA_id $TA_name</b> is assigned to <b>$course</b> to do <b>$task</b> in <b>$term</b> of <b>$year</b>";

		//output new TA workload:
		echo "<br><br><b>New TA workload:</b><br>";

		$query_TAs_view = "SELECT DISTINCT Students.id, FName, LName, SUM(Log_of_TAs.Hours) AS Hours FROM Students, Log_of_TAs WHERE Students.id = Log_of_TAs.id_from_Students_from_Graduates_from_TAs AND Log_of_TAs.Year >= 2019 GROUP BY (Log_of_TAs.id_from_Students_from_Graduates_from_TAs)";

		$result_TAs_view = $connection->query($query_TAs_view);
		if (!$result_TAs_view) {
			echo "Could not receive query result - TA_view 2" . '<br><br>';
			die ($connection->error);
		}

		show_table($result_TAs_view);
	}
	
	
	
}
?>
