<!DOCTYPE html>
<html>
<head>
	<title>Add Graduate Funding</title>
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
//UTIL FUNCTION connect($db_hostname, $db_username, $db_password, $db_database)
$connection = connect_to_db($db_hostname, $db_username, $db_password, $db_database);
?>

<?php
$thesis_sql = "SELECT id, FName, LName FROM Students WHERE id IN (SELECT id_from_Students_from_Graduates FROM Thesis_Students) AND Students.GPA >= 3.0";
$result_thesis = $connection->query($thesis_sql);
if (!$result_thesis) {
	echo "Could not receive query result - thesis_sql, grad funding" . '<br><br>';
	die ($connection->error);
}
?>

<form action="add_grad_funding.php" method="post">
	Select a thesis student to add graduate funding: <select name="student">
		<?php
		while ($row = $result_thesis->fetch_array(MYSQLI_NUM)) {
			echo "<option value=\"$row[0]\">$row[0] $row[1] $row[2] </option>";
		}
		?>
	</select>
	<br><br><input type="submit" value="Select">
</form>

<br>


<?php
//process selected student
if (isset($_POST['student'])) {
	$student_id = $_POST['student'];
		
	//check if funding is available
	$sql = "SELECT Supervisors.id_from_Research_Funding FROM Supervisors, Thesis_Students WHERE Thesis_Students.id_from_Students_from_Graduates = \"$student_id\" AND Thesis_Students. id_from_Supervisors = Supervisors.id";
	$result = $connection->query($sql);
	if (!$result) {
		echo "Could not receive query result - funding available" . '<br><br>';
		die ($connection->error);
	}
	$row = $result->fetch_array(MYSQLI_NUM);
	$funding_no = $row[0];
	if ($row[0] != NULL){
		echo "Supervisor funding <b>OK</b><br>";
		$funding_OK = TRUE;
	} else {
		echo "Supervisor does not provide funding<br>";
	}
	
	if ($funding_OK) {
		//add number of funding to student

		$sql = "UPDATE Thesis_Students SET id_from_Research_Funding=\"$funding_no\" WHERE id_from_Students_from_Graduates = \"$student_id\"";
		$result = $connection->query($sql);
		if (!$result) {
			echo "Could not receive query result - funding insert" . '<br><br>';
			die ($connection->error);
		}

		echo "<br>Funding added.";
	} else {
		echo "<br>Application declined.";
	}
}
?>
</body>
</html>
