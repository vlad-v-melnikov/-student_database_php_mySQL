<!DOCTYPE html>
<html>
<head>
	<title>Add New TA</title>
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

<b>Current TAs</b><br>

<?php
//show current TAs
$result_show_TAs = $connection->query("SELECT id, FName, LName FROM Students, TAs WHERE Students.id = TAs.id_from_Students_from_Graduates");
show_table($result_show_TAs);
?>

<br>
<?php
//select new TAs
$grad_sql = "SELECT id, FName, LName FROM Students WHERE id IN (SELECT id_from_Students FROM Graduates) AND Students.GPA >= 3.2 AND id NOT IN (SELECT id FROM Students, TAs WHERE Students.id = TAs.id_from_Students_from_Graduates)";

$result_grad = $connection->query($grad_sql);
if (!$result_grad) {
	echo "Could not receive query result - grad_sql, new TA" . '<br><br>';
	die ($connection->error);
}
?>

<form action="add_new_TA.php" method="post">
	Select a grad student to add to TAs: <select name="student">
		<?php
		while ($row = $result_grad->fetch_array(MYSQLI_NUM)) {
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
	$student_name = get_name($connection, $student_id);

	$sql = "INSERT INTO TAs VALUES (\"$student_id\")";
	$result = $connection->query($sql);
	if (!$result) {
		echo "Could not receive query result - insert new TA" . '<br><br>';
		die ($connection->error);
	}

	echo "<br>Added <b>$student_id $student_name</b> to the TA roster.";
	echo "<b><br>New TA Roster</b><br>";
	//new TAs
	$result_show_TAs = $connection->query("SELECT id, FName, LName FROM Students, TAs WHERE Students.id = TAs.id_from_Students_from_Graduates");
	show_table($result_show_TAs);
}
?>

<?php

?>

</body>
</html>
