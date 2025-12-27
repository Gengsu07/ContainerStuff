from abc import ABC, abstractmethod

from dotenv import load_dotenv

load_dotenv()
import os

import psycopg2 as pg


class IDatabase(ABC):
    @abstractmethod
    def connect(self):
        pass

    @abstractmethod
    def disconnect(self):
        pass


class Postgre(IDatabase):
    def __init__(self):
        self.host = os.getenv("POSTGRE_HOST")
        self.user = os.getenv("POSTGRE_USER")
        self.password = os.getenv("POSTGRE_PASSWORD")
        self.database = os.getenv("POSTGRE_DB")

    def connect(self):
        conn_pg = pg.connect(
            f"postgresql://{self.user}:{self.password}@{self.host}/{self.database}"
        )
        cur = conn_pg.cursor()
        return conn_pg, cur

    def query(self, query):
        conn_pg, cur = self.connect()
        cur.execute(query)
        hasil = cur.fetchall()
        cur.close()
        self.disconnect(conn_pg)
        return hasil

    def disconnect(self, conn_pg):
        conn_pg.close()


if __name__ == "__main__":
    db = Postgre()
    data = db.query("SELECT * FROM green_tripdata limit 20")
    print(data)
