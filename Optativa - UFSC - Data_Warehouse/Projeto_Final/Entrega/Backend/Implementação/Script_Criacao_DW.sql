USE DWUFSC; 

CREATE TABLE Fato_Desempenho (
                Candidato_key INT NOT NULL,
                Vestibular_key INT NOT NULL,
                Escola_key INT NOT NULL,
                Acertos_Biologia DOUBLE PRECISION NOT NULL,
                Acertos_Geografia DOUBLE PRECISION NOT NULL,
                Acertos_Matematica DOUBLE PRECISION NOT NULL,
                Acertos_Lingua_Estrangeira DOUBLE PRECISION NOT NULL,
                Acertos_Portugues DOUBLE PRECISION NOT NULL,
                Acertos_Fisica DOUBLE PRECISION NOT NULL,
                Acertos_Historia DOUBLE PRECISION NOT NULL,
                Acertos_Quimica DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (Candidato_key, Vestibular_key, Escola_key)
);


ALTER TABLE Fato_Desempenho ADD CONSTRAINT dim_candidato_fato_desempenho_fk
FOREIGN KEY (Candidato_key)
REFERENCES Dim_Candidato (Candidato_key)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_Desempenho ADD CONSTRAINT dim_escola_fato_desempenho_fk
FOREIGN KEY (Escola_key)
REFERENCES Dim_Escola (Escola_key)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_Desempenho ADD CONSTRAINT dim_vestibular_fato_desempenho_fk
FOREIGN KEY (Vestibular_key)
REFERENCES Dim_Vestibular (Vestibular_key)
ON DELETE NO ACTION
ON UPDATE NO ACTION;