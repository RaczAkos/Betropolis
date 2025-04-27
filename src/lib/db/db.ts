import mysql from "mysql2/promise"

let mysqlconn:any = null;

// Connect to database
export function dbConnect(){
    if (!mysqlconn){
        mysqlconn = mysql.createConnection({
            host: "localhost", // XAMPP
            user: "root",
            password: "",
            database: "betropolis",
            multipleStatements: true
        });
    }

    return mysqlconn;
}