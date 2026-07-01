import React, { useState, useEffect } from 'react';

function App() {
  // Setup variables to hold our data and loading state
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch data from the Java Backend endpoint
    fetch('/api/hello') 
      .then((response) => response.json())
      .then((jsonData) => {
        setData(jsonData);
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error communicating with backend:", error);
        setLoading(false);
      });
  }, []);

  return (
    <div style={{ textAlign: 'center', marginTop: '50px', fontFamily: 'Arial' }}>
      <h1>My Full-Stack Application</h1>
      <hr style={{ width: '50%' }} />
      
      {loading ? (
        <p>Connecting to backend...</p>
      ) : data ? (
        <div style={{ padding: '20px', background: '#f0f0f0', display: 'inline-block', borderRadius: '8px' }}>
          <h3 style={{ color: 'green' }}>Backend Response:</h3>
          <p><strong>Message:</strong> {data.message}</p>
          <p><strong>Status:</strong> {data.status}</p>
        </div>
      ) : (
        <p style={{ color: 'red' }}>Failed to load data from backend.</p>
      )}
    </div>
  );
}

export default App;