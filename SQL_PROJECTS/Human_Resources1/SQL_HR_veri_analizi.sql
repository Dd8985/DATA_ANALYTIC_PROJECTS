--hr.employees tablosu ile çalışıp bir takım analizler yapacağız
--tablodaki tüm satır ve sütunları görelim:
select * from hr.EMPLOYEES

--tablodan bazı sütunları seçelim:
select employee_ID, first_name, salary from hr.employees

--var olan maaşa 10000 lira zam yapalım:
select first_name, last_name, salary + 10000 as new_salary from hr.employees

--tablodaki sütunların detaylı bilgisine bakalım:
describe hr.employees

--isim ve soyisimi beraber yazalım:
select first_name ||' '|| last_name as new_name from hr.employees

--tabloda kaç satır olduğuna bakalım:
select count(*) from hr.EMPLOYEES

--istenilen sütunda tekrar eden verileri bir sefer gösterir yani kaç farklı veri var:
select distinct(department_id) from hr.employees

--sadece department_id'si 90 olan kayıları getirelim:
select first_name,last_name,department_id from hr.employees where department_id=90

--soyadı 'King' olan kişileri görelim:
select first_name, last_name from hr.employees where last_name='King'

--maaşı 10000 den büyük olanları görelim:
select first_name, last_name, salary from hr.employees where salary > 10000 

--maaşı 10000 ile 15000 arasında olanlara bakalım:
select first_name, last_name, salary from hr.employees where salary between 10000 and 15000

--department numarası 10,20 ve 30 olan kişileri görelim:
select first_name, last_name, department_id from hr.employees where department_id in (10,20,30)

--department numarası 10,20 ve 30 olmayan kişileri görelim:
select first_name, last_name, department_id from hr.employees where department_id not in (10,20,30)

--baş harfi S ile başlayan kişileri görelim:
select first_name, last_name from hr.employees where first_name like 'S%'

--manager_ıd null olan kayıtları görelim:
select first_name, last_name, department_id, manager_id from hr.employees where manager_id is null

--maaşı 10000 den büyük ve department_id'si 90 olan kişileri görelim:
select first_name, last_name, salary, department_id from hr.employees 
where salary > 10000 and department_id=90

--department numarası 50 ya da 90 olanları ve maaşı 10000 den büyük olanları görelim:
select first_name, last_name, salary, department_id from hr.employees 
where (department_id=50 or department_id=90) and salary > 10000

--maaşları büyükten küçüğe doğru sıralayalım:
select first_name, last_name, salary from hr.employees order by salary desc

--departmen numarası 10,20 ve 30 olmayanları getirelim ve getirirken de maaşları büyükten küçüğe sıralayalım
--ve ilk 10 satırı görelim:
select first_name, last_name, salary, department_id from hr.employees 
where department_id not in (10,20,30) order by salary desc 
fetch first 10 rows only

--departmen numarası 10,20 ve 30 olmayanları getirelim ve getirirken de maaşları büyükten küçüğe sıralayalım
--ve ilk 5 satırı geçip sonraki 5 satırı görelim:
select first_name, last_name, salary, department_id from hr.employees 
where department_id not in (10,20,30) order by salary desc 
offset 5 rows 
fetch first 5 rows only

--department numarası (10,20,30) olmayan ilk 20 kayıtı maaşa göre sıralayarak getirelim 
--eğer içlerinde maaşları aynı olanlar varsa bu sefer department numarasına göre sıralayalım:
select first_name, last_name, salary, department_id from hr.employees 
where department_id not in (10,20,30) order by salary desc, department_id desc 
fetch first 20 rows only

--first_name sütununun daki isimleri küçük harfe çevirelim:
select first_name, lower (first_name) from hr.employees

--first_name sütununun daki isimleri büyük harfe çevirelim:
select first_name, upper (first_name) from hr.employees

--ilk harfleri büyük yapalım:
select first_name, initcap(first_name) from hr.employees

--isim ve soyisimi bitişik yazalım:
select concat(first_name, last_name) from hr.employees

--first_name sütunundaki isimlerin ilk 4 harfini yazdıralım:
select first_name, salary, substr(first_name,1,4) from hr.employees

--istenilen sütunun içindeki kelimelerin uzunluğunu verir:
select first_name, salary, length(first_name) from hr.employees

--maaşı 10 karaktere tamamlamak için sağdan yada soldan * koyalım:
select first_name, last_name, salary, lpad(salary,10,'*') from hr.employees
select first_name, last_name, salary, rpad(salary,10,'*') from hr.employees

--nümeric değerleri yuvarlayalım:
select salary, commission_pct, round(salary/commission_pct) from hr.employees 
where commission_pct is not null

--employee_id'si çift sayı olanları görelim:
select first_name, employee_id from hr.employees where mod(employee_id,2)=0

--employee_id'si tek sayı olanları görelim:
select first_name, employee_id from hr.employees where mod(employee_id,2)=1

--varsa eğer null değerleri istenilen değere döndürmek için nvl fonksiyonu kullanılır:
select first_name, last_name, nvl(commission_pct,0) from hr.employees

--meslek gruplarına göre maaşlara zam yapmak istediğimizde;
SELECT
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    JOB_ID,
    CASE JOB_ID
        WHEN 'IT_PROG'  THEN
            SALARY * 1.10
        WHEN 'ST_CLERK' THEN
            SALARY * 1.15
        WHEN 'SA_RAP'   THEN
            SALARY * 1.20
        ELSE
            SALARY
    END ZAMLI_MAAŞ
FROM
    HR.EMPLOYEES
   

--maaş oranlarına göre derece belirleyelim:
SELECT
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    CASE
        WHEN SALARY < 7000  THEN
            'az'
        WHEN SALARY < 11000 THEN
            'orta'
        WHEN SALARY < 20000 THEN
            'iyi'
        ELSE
            'mükemmel'
    END MAAŞ_DERECE
FROM
    HR.EMPLOYEES


--aggregation fonksiyonlara bakalım:
select avg(salary), max(salary), min(salary), sum(salary) from hr.employees

--istenilen department da çalışanların ortalama maaşları, en yüksek  maaşlarını görelim:
select department_id, avg(salary), max(salary), min(salary), sum(salary) from hr.EMPLOYEES
group by department_id order by department_id asc

--department_ıd ve job_ıd  sütunlarına göre gruplayalım:
select department_id, job_ıd, sum(salary) from hr.employees group by department_id, job_ıd

--en yüksek maaşı olan department hangisiidr?:
select department_id from hr.employees where salary = (select max(salary) from hr.employees)

--departmanlarda kaç kişinin çalıştığını görelim:
select department_id, job_ıd, sum(salary), count(employee_id) from hr.employees
group by department_id,job_ıd order by department_id

--çalışan sayısı 3 den büyük olanları ve department numarası 40 dan büyük olanları getirelim:
SELECT
    DEPARTMENT_ID,
    JOB_ID,
    SUM(SALARY),
    COUNT(EMPLOYEE_ID)
FROM
    HR.EMPLOYEES
WHERE
    DEPARTMENT_ID > 40
GROUP BY
    DEPARTMENT_ID,
    JOB_ID
HAVING
    COUNT(EMPLOYEE_ID) > 3
ORDER BY
    1


--kaç farklı departman vardır?:
select count(distinct(department_ıd)) from hr.employees    

--department numarasına göre gruplandığında en yüksek maaş nedir:
select max(avg(salary)) from hr.employees group by department_id

--en fazla parayı kim alıyor ve ne kadar alıyor görelim:
select * from hr.employees where salary = (select max(salary) from hr.employees)

--hr.employees tablosu ile hr.departments tablosunu birleştirelim
SELECT
    HR.EMPLOYEES.FIRST_NAME,
    HR.EMPLOYEES.LAST_NAME,
    HR.DEPARTMENTS.DEPARTMENT_NAME
FROM
         HR.EMPLOYEES
    JOIN HR.DEPARTMENTS ON HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID


--hr.employees , hr.departments ve hr.locations tablolarını birleştirelim:
SELECT
    HR.EMPLOYEES.FIRST_NAME,
    HR.EMPLOYEES.LAST_NAME,
    HR.DEPARTMENTS.DEPARTMENT_NAME,
    HR.LOCATIONS.CITY
FROM
         HR.EMPLOYEES
    JOIN HR.DEPARTMENTS ON HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID
    JOIN HR.LOCATIONS ON HR.LOCATIONS.LOCATION_ID = HR.DEPARTMENTS.LOCATION_ID


--employees, departments, locations ve countries tablolarını birleştirelim:
  SELECT
    HR.EMPLOYEES.FIRST_NAME,
    HR.EMPLOYEES.LAST_NAME,
    HR.DEPARTMENTS.DEPARTMENT_NAME,
    HR.LOCATIONS.CITY,
    HR.COUNTRIES.COUNTRY_NAME
FROM
         HR.EMPLOYEES
    JOIN HR.DEPARTMENTS ON HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID
    JOIN HR.LOCATIONS ON HR.LOCATIONS.LOCATION_ID = HR.DEPARTMENTS.LOCATION_ID
    JOIN HR.COUNTRIES ON HR.LOCATIONS.COUNTRY_ID = HR.COUNTRIES.COUNTRY_ID 


--left outer join:iki tabloyu birleştirirken ilk yazılan tablodaki tüm kayıları ve ikinci yazılan tablodan
--sadece eşleşen kayıtları getirir.eğer sağdaki tabloda eşleşen bir kayıt yoksa bu sefer o satırlar NULL olur.
SELECT
    HR.EMPLOYEES.EMPLOYEE_ID,
    HR.EMPLOYEES.FIRST_NAME,
    HR.EMPLOYEES.LAST_NAME,
    HR.DEPARTMENTS.DEPARTMENT_NAME
FROM
    HR.EMPLOYEES
    LEFT OUTER JOIN HR.DEPARTMENTS ON HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID  


--rigth outer join:join den sonra yazılan yani ikinci yazılan tablodaki tüm kayıtları getirir.
--soldaki tabloda eşleşme varsa, veriler gösterilir yoksa NULL olur.
SELECT
    HR.EMPLOYEES.EMPLOYEE_ID,
    HR.EMPLOYEES.FIRST_NAME,
    HR.EMPLOYEES.LAST_NAME,
    HR.DEPARTMENTS.DEPARTMENT_NAME
FROM
    HR.EMPLOYEES
    right outer JOIN HR.DEPARTMENTS ON HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID 


--full outer join:her iki tablodan da tüm verileri getirir.eşleşen kayıtlar birleştirilir yoksa NULL olur.
 SELECT
    HR.EMPLOYEES.EMPLOYEE_ID,
    HR.EMPLOYEES.FIRST_NAME,
    HR.EMPLOYEES.LAST_NAME,
    HR.DEPARTMENTS.DEPARTMENT_NAME
FROM
    HR.EMPLOYEES
    FULL OUTER JOIN HR.DEPARTMENTS ON HR.EMPLOYEES.DEPARTMENT_ID = HR.DEPARTMENTS.DEPARTMENT_ID


--verilerdeki LEX adlı kişiden daha fazla maaşları görelim:
select employee_id, first_name, salary from hr.EMPLOYEES
where salary > (select salary from hr.employees where first_name='Lex')   

--employee_id'si 145 olan kişi ile aynı işi yapan ama ondan daha düşük maaş alanları görelim:
select employee_id, first_name, salary from hr.EMPLOYEES
where job_ıd = (select JOB_ID from hr.employees where employee_id = 145)
and salary < (select salary from hr.employees where employee_id = 145) 

--maaşı en düşük olan kişinin bilgilerini görelim:
select * from hr.employees where salary = (select min(salary) from hr.EMPLOYEES)

--job title 'IT_PROG' olan kişilerden daha düşük maaş alanları görelim (ANY-ALL):
select employee_id, first_name, salary from hr.EMPLOYEES
where salary < all (select salary from hr.employees where job_ıd='IT_PROG')

select employee_id, first_name, salary from hr.EMPLOYEES
where salary < any (select salary from hr.employees where job_ıd='IT_PROG')

--ANALİTİK SQL (tüm verileri tek tabloda görme imkanı sağlar)

--over fonksiyonu: maaşları alt alta toplaya toplaya bir alt satıra iner ve en altta toplam maaş gözükür.
select first_name, salary, sum(salary) over (order by first_name) as toplam_maaş from hr.employees

--partition by fonksiyonu: her bir departmanı kendi içinde toplar ve 
--farklı bir departmana geçince maaş o departmana göre hesaplanıp alt alta toplanır.

SELECT
    LAST_NAME,
    DEPARTMENT_ID,
    SALARY,
    SUM(SALARY)
    OVER(PARTITION BY DEPARTMENT_ID
         ORDER BY
             SALARY
    ) AS DEPARTMAN_MAAŞLARI
FROM
    HR.EMPLOYEES
ORDER BY
    DEPARTMENT_ID


--rows beetween unbounded precedding and current row fonksiyonu: varsayılan kod yani yazılmasada olur.
SELECT
    LAST_NAME,
    DEPARTMENT_ID,
    SALARY,
    SUM(SALARY)
    OVER(PARTITION BY DEPARTMENT_ID
         ORDER BY
             EMPLOYEE_ID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS TOPLAM_MAAŞ
FROM
    HR.EMPLOYEES
ORDER BY
    EMPLOYEE_ID


--lag fonksiyonu: bir önceki satırdaki maaş neyse o satıra onu yazdırır
select employee_id, first_name, salary, lag(salary,1) over (order by salary) as maaş from hr.employees   

--lead fonksiyonu: ilk satırdan başlar ve ilk satıra bir sonraki maaşı vererek devam eder.
select first_name, salary, lead(salary,1) over (order by salary) as maaş from hr.employees

--listagg fonksiyonu: departman bazında gruplandığında çalışanların isimlerini yatay olarak verir.
select department_id, listagg(first_name,',') within group (order by department_id) as çalışanlar
from hr.employees group by department_id

--rank() ve dense_rank() fonksiyonu: departmana göre gruplandığında en yüksek maaşlı kişiden başlayarak sıralar.
select last_name, department_id, salary, rank() 
over (partition by department_id order by salary desc) as sıralama
from hr.employees where department_id = 50 order by department_id








