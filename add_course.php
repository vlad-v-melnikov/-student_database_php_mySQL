<!DOCTYPE html>
<html>
<head>
	<title>Add Course for a Student</title>
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

<?php
//these arrays should be queries from the database
//fill students and courses
$students_sql = "SELECT id, FName, LName FROM Students";
$result_students = $connection->query($students_sql);
if (!$result_students) {
	echo "Could not receive query result" . '<br><br>';
	die ($connection->error);
}

$courses_sql = "SELECT id FROM Courses";
$result_courses = $connection->query($courses_sql);
if (!$result_courses) {
	echo "Could not receive query result" . '<br><br>';
	die ($connection->error);
}
?>

<form action="add_course.php" method="post">
	Select a student to add a course: <select name="student">
		<?php
		while ($row = $result_students->fetch_array(MYSQLI_NUM)) {
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
	<input type="submit" value="Select">
</form>

<br>


<?php
//process selected student
if (isset($_POST['student']) && isset($_POST['course'])) {
	$student_id = $_POST['student'];
	$course_name = $_POST['course'];
	$student_name = get_name($connection, $student_id);
	
	echo "<b>$student_id $student_name</b> wants to take <b>$course_name</b><br><br>";

	//find prereqs
	$prereq_sql = "SELECT id_from_Courses_Prereq FROM Prereg WHERE id_from_Courses_Target = \"" . $course_name ."\"";

	$result_prereq = $connection->query($prereq_sql);
	if (!$result_prereq) {
		echo "Could not receive query result - prereq" . '<br><br>';
		die ($connection->error);
	}

	/*find subjects taken by this student - make sure all the prerequisites are among them, and the grade is a passing grade*/
	//subjects by this student
	$list_of_prereq = array();
	while ($row = $result_prereq->fetch_array(MYSQLI_NUM)) {
		array_push($list_of_prereq, $row[0]);
	}
	$gradeOK = TRUE;
	$prereqOK = TRUE;

	foreach($list_of_prereq as $value) {
		//did the student take it? What is the grade?
		$grade_sql = "SELECT Grade FROM Students_registered_Sections WHERE id_from_Courses_from_Sections = \"$value\" AND id_from_Students = \"$student_id\"";


		$result_grade = $connection->query($grade_sql);
		if (!$result_grade) {
			echo "Could not receive query result - grades" . '<br><br>';
			die ($connection->error);
		}

		$prereq_grades = array();
		while ($row = $result_grade->fetch_array(MYSQLI_NUM)) {
			array_push($prereq_grades, $row[0]);
		}
	}
	
	$no_of_prereq = count($list_of_prereq);
	$no_of_grades = is_array($prereq_grades) ? count($prereq_grades) : 0;

	//check number of elements
	if ($no_of_prereq > $no_of_grades) {
		echo "Prerequisite courses were not taken<br><br>";
		$prereqOK = FALSE;
	}

	//check passing grade
	if ($prereqOK) {
		echo "Prerequisites <b>OK</b><br>";
		for ($i = 0; $i < count($list_of_prereq); ++$i){
			$check_grade_sql = "SELECT Passing_Grade FROM Courses WHERE id=\"$list_of_prereq[$i]\"";
			$result_check = $connection->query($check_grade_sql);
			if (!$result_check) {
				echo "Could not receive query result - passing grade" . '<br>';
				die ($connection->error);
			}
			$row = $result_check->fetch_array(MYSQLI_NUM);
			
			//GRADE displayed
			/*echo "Grade for <b>$list_of_prereq[$i]</b>: $prereq_grades[$i]<br>";
			echo "Passing grade:  $row[0]<br>";*/

			if ($prereq_grades[$i] < $row[0]) {
				$prereqOK = FALSE;
				echo "<br>Grade <b>NOT OK</b><br>";
				break;
			}
			echo "Grade <b>OK</b><br>";
		}
	}

	if ($prereqOK && $gradeOK){
		//Section selector
		$section_sql = "SELECT id FROM Sections WHERE id_from_Courses = \"$course_name\"";
		$result_sections = $connection->query($section_sql);
		if (!$result_sections) {
			echo "Could not receive query result - sections" . '<br><br>';
			die ($connection->error);
		}
		echo"<br>
		<form action=\"add_course.php\" method=\"post\">
		Select a section: <select name=\"section\">";
		while ($row = $result_sections->fetch_array(MYSQLI_NUM)) {
			echo "<option value=\"$row[0]\">$row[0] </option>";
		}
		echo"
		</select>
		<input type=\"hidden\" name = \"course_name\" value = \"$course_name\">
		<input type=\"hidden\" name = \"student_id\" value = \"$student_id\">
		<input type=\"submit\" value=\"Select\">
		</form>";
	} else {
		echo "<br>Cannot add <b>$course_name</b> for <b>$student_id</b>";
	}
}

if (isset($_POST['section'])) {
	$section = $_POST['section'];
	$course_name = $_POST['course_name'];
	$student_id = $_POST['student_id'];
	
	//query to add a record to student registration
	$insert_sql = "INSERT INTO Students_registered_Sections VALUES (\"$section\", \"$course_name\", \"$student_id\", \"Fall\", \"2019\", \"0\")";
	$result_insert = $connection->query($insert_sql);
	if (!$result_insert) {
		echo "Could not receive query result - sections" . '<br><br>';
		die ($connection->error);
	} else {
		$student_name = get_name($connection, $student_id);
		echo "<br><b>$course_name</b> added for <b>$student_id $student_name</b>, section <b>$section</b>";
	}
}

?>

</body>
</html>
