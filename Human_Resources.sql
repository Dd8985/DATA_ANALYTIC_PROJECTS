--job_history tablosundan iş değiştirmiş kişileri görelim:

select * from HR.job_history;
select distinct employee_id from HR.job_history;

--şuan çalışıp geçmişte hiç iş değiştirmemiş kişileri görelim:

select employee_id, first_name, last_name from hr.employees
where employee_id not in (select employee_id from hr.job_history);

--employees tablosunda olmayan ama geçmişte çalışanlar yani emekli olanları görelim:

select hr.job_history.employee_id, hr.job_history.start_date, hr.job_history.end_date from hr.job_history
where hr.job_history .employee_id not in (select employee_id from hr.employees);

--iş değiştirenleri, değiştirmeyenleri ve artık çalışmayıp emekli olanları tek tablo ile görelim:


      SELECT 
    COALESCE(e.employee_id, jh.employee_id) AS employee_id, e.first_name, e.last_name,
    CASE 
        WHEN e.employee_id IS NOT NULL AND jh.employee_id IS NOT NULL THEN 'İş Değiştirmiş'
        WHEN e.employee_id IS NOT NULL AND jh.employee_id IS NULL THEN 'İş Değiştirmemiş'
        WHEN e.employee_id IS NULL AND jh.employee_id IS NOT NULL THEN 'Artık Çalışmıyor (Emekli Olmuş Olabilir)'
    END AS durum
FROM hr.employees e
FULL OUTER JOIN (SELECT DISTINCT employee_id FROM hr.job_history) jh
ON e.employee_id = jh.employee_id;