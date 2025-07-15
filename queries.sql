-- 1. نمایش نام و نام خانوادگی دانش‌آموزان همراه با آخرین رنگ کمربندشان (Subquery)
SELECT s.first_name, s.last_name, p.belt_color, p.promotion_date
FROM Student s
JOIN Promotion p ON s.student_id = p.student_id
WHERE p.promotion_date = (
    SELECT MAX(p2.promotion_date)
    FROM Promotion p2
    WHERE p2.student_id = s.student_id
);

-- 2. محاسبه تعداد ارتقاء هر دانش‌آموز (GROUP BY)
SELECT s.first_name, s.last_name, COUNT(p.promotion_id) AS promotion_count
FROM Student s
LEFT JOIN Promotion p ON s.student_id = p.student_id
GROUP BY s.student_id;

-- 3. محاسبه میانگین تعداد ارتقاء برای کل دانش‌آموزان (AVG + Subquery)
SELECT AVG(promotion_count) AS avg_promotions_per_student
FROM (
    SELECT COUNT(*) AS promotion_count
    FROM Promotion
    GROUP BY student_id
) AS sub;

-- 4. ساخت View برای نمایش آخرین ارتقاء هر دانش‌آموز (VIEW)
CREATE VIEW LatestPromotion AS
SELECT s.student_id, s.first_name, s.last_name, p.belt_color, MAX(p.promotion_date) AS latest_promotion_date
FROM Student s
JOIN Promotion p ON s.student_id = p.student_id
GROUP BY s.student_id;

-- 5. نمایش نام مربیانی که بیشتر از یک شاگرد داشته‌اند (GROUP BY + HAVING)
SELECT i.first_name, i.last_name, COUNT(DISTINCT s.student_id) AS student_count
FROM Instructor i
JOIN Student s ON i.instructor_id = s.instructor_id
GROUP BY i.instructor_id
HAVING COUNT(DISTINCT s.student_id) > 1;

-- 6. نمایش دانش‌آموزانی که حداقل ۲ بار ارتقاء گرفته‌اند (Subquery)
SELECT first_name, last_name
FROM Student
WHERE student_id IN (
    SELECT student_id
    FROM Promotion
    GROUP BY student_id
    HAVING COUNT(*) >= 2
);

-- 7. نمایش تعداد دانش‌آموزان هر باشگاه (GROUP BY)
SELECT c.name AS club_name, COUNT(s.student_id) AS student_count
FROM Club c
LEFT JOIN Student s ON c.club_id = s.club_id
GROUP BY c.club_id;

-- 8. نمایش رنگ‌های کمربند و تعداد هر رنگ (GROUP BY)
SELECT belt_color, COUNT(*) AS count_per_color
FROM Promotion
GROUP BY belt_color;

-- 9. نمایش مربیان و تعداد ارتقاءهایی که انجام داده‌اند (GROUP BY)
SELECT i.first_name, i.last_name, COUNT(p.promotion_id) AS promotions_given
FROM Instructor i
LEFT JOIN Promotion p ON i.instructor_id = p.instructor_id
GROUP BY i.instructor_id;

-- 10. نمایش تمام اطلاعات دانش‌آموزانی که هنوز ارتقاء نگرفته‌اند (LEFT JOIN + IS NULL)
SELECT s.*
FROM Student s
LEFT JOIN Promotion p ON s.student_id = p.student_id
WHERE p.promotion_id IS NULL;
