import mysql from "mysql2/promise"

let mysqlconn:any = null;

export function dbConnect(){
    if (!mysqlconn){
        mysqlconn = mysql.createConnection({
            host: "localhost", // XAMPP
            user: "root",
            password: "",
            database: ""
        });
    }

    return mysqlconn;
}