--Pregunta 1
SELECT CCID, CCNOMBRE AS CLIENTE, CCINDUSTRIA AS INDUSTRIA
FROM E1_CLIENTECORP
WHERE(
    REFERCCID IS NOT NULL
);

--Pregunta 2
SELECT IR.INSID AS COD_INSPECTOR, IR.INSNOMBRE AS NOMBRE,
    TO_CHAR(IP.SGTEINSP, 'MM') AS MES, COUNT(*) AS CANTIDAD
FROM E1_INSPECTOR IR, E1_INSPECCIONA IP
WHERE(
    IR.INSID = IP.IDINSPECTOR 
    AND IP.SGTEINSP > '15/05/22'
)
GROUP BY IR.INSID, IR.INSNOMBRE, TO_CHAR(IP.SGTEINSP, 'MM')
ORDER BY 1 ASC, 4 ASC;

--Pregunta 3
SELECT AP.EDIFICIOID, AP.APARTNO AS NRO_APARTAMENTO
FROM E1_APARTAMENTO AP, E1_CLIENTECORP CC
WHERE(
    AP.CCID = CC.CCID
    AND CC.CCNOMBRE = 'SPOTI5'
);

--Pregunta 4

CREATE VIEW DEP_BARCELONA AS
SELECT AP.EDIFICIOID AS EDIFICIOID, AP.APARTNO AS NRO_APARTAMENTO
FROM E1_APARTAMENTO AP, E1_CLIENTECORP CC
WHERE(
    AP.CCID = CC.CCID
    AND CC.CCNOMBRE = 'BARCELONA'
);

SELECT * FROM dep_barcelona;
SELECT DISTINCT PL.PID, PL.PNOMBRE
FROM E1_PERSONAL PL, E1_LIMPIEZA LP
WHERE(
    PL.PID = LP.PID
    AND
    (LP.EDIFICIOID||LP.APARTNO IN 
        (SELECT EDIFICIOID||NRO_APARTAMENTO FROM DEP_BARCELONA)
    )
);