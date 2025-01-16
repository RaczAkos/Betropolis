import { dbConnect } from "$lib/db/db";

export async function post(request) {
  // Get the data from the POST request body
  const { name, email } = request.body;

  // Prepare the query to insert the data into the database
  const query = 'INSERT INTO users (name, email) VALUES (?, ?)';

  return new Promise((resolve, reject) => {
    // Execute the query
    db.query(query, [name, email], (err, results) => {
      if (err) {
        console.error('Error inserting data:', err);
        return reject({
          status: 500,
          body: { message: 'Error inserting data into the database' }
        });
      }

      // Return success response
      resolve({
        status: 200,
        body: { message: 'Data inserted successfully' }
      });
    });
  });
}
