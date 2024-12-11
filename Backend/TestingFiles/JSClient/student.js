process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
const URL_BASE = 'https://localhost:19200/api';

async function httpMethod(url, method, token, haveBody, body, functionName) {
    try {
        let response;

        if (haveBody === true) {
            response = await fetch(url, {
                method: method,
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    'accept': '*/*'
                },
                body: JSON.stringify(body)
            });
        } else {
            response = await fetch(`${url}${body}`, {
                method: method,
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    'accept': '*/*'
                }
            });
        }

        const data = await response.json();
        console.log(functionName, data);
        return data;
    } catch (error) {
        console.error('Error fetching:', error);
    }
}

async function login(email, passwordHash) {
    const url = 'https://localhost:19200/api/Student/LogIn';
    const response = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ email: email, passwordHash: passwordHash })
    });

    if (!response.ok) {
        throw new Error(`Error: ${response.statusText}`);
    }

    const data = await response.json();
    console.log('login:', data);
    return data;
}


const email = 'kpachac@ulasalle.edu.pe';
const passwordHash = "XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg=";

login(email, passwordHash).then(data => {
    // Assignments Operations
    
    httpMethod
    (
        `${URL_BASE}/Assignment/GetAllByCourseForStudent?courseId=`, 
        'GET', 
        data.token, 
        false,
        '5500125e-16f5-4b77-9220-cc4dab69c100',
        'Assignment.GetAllByCourseForStudent'
    )

}).catch(error => {
    console.error(error);
});

