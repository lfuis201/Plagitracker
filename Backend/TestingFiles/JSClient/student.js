process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

async function fetchStudent() {
    const url = 'http://localhost:9100/api/Student/Get?id=1979d2a7-de35-4d83-9aa9-857171cba7fa';
    
    try {
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Accept': '*/*'
            }
        });

        if (!response.ok) {
            throw new Error(`Error: ${response.status} ${response.statusText}`);
        }

        const data = await response.json();
        console.log('Student Data:', data);
    } catch (error) {
        console.error('Error fetching student:', error);
    }
}

// Call the function
fetchStudent();
