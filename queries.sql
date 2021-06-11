-- Create table for Retirement Titles
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
	ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

--Create table for most recent job titles about to retire
-- Retrieve number of titles 
CREATE TABLE retiring_titles AS (
SELECT COUNT (title), title
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC
);

-- Create Mentorship Eligibility Table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date, 
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (me.emp_no)
me.emp_no,
me.first_name,
me.last_name,
me.birth_date,
me.from_date,
me.to_date,
me.title
FROM mentorship_eligibility AS me
WHERE (me.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (me.to_date = '9999-01-01')
ORDER BY me.emp_no ASC;
