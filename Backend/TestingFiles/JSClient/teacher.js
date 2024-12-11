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
    const url = 'https://localhost:19200/api/Teacher/LogIn';
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

async function getAllByCourse(courseId, token) {
    const url = `https://localhost:9200/api/Assignment/GetAllByCourse?courseId=${courseId}`;

    try {
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        });

        if (!response.ok) {
            throw new Error(`Error: ${response.statusText}`);
        }

        const data = await response.json();
        console.log(data);
        return data;
    } catch (error) {
        console.error('Error fetching assignments:', error);
    }
}

async function getAllByCourseWithOutToken(courseId) {
    const url = `http://localhost:9100/api/Assignment/GetAllByCourse?courseId=${courseId}`;

    try {
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (!response.ok) {
            throw new Error(`Error: ${response.statusText}`);
        }

        const data = await response.json();
        console.log(data);
        return data;
    } catch (error) {
        console.error('Error fetching assignments:', error);
    }
}

async function getPrivateInfoTeacher(token) {
    const url = `${URL_BASE}/Teacher/GetPrivateInfo`;

    try {
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        });

        if (!response.ok) {
            throw new Error(`Error: ${response.statusText}`);
        }

        const data = await response.json();
        console.log('getPrivateInfoTeacher:', data);
        return data;
    } catch (error) {
        console.error('Error fetching:', error);
    }
}

async function deleteTeacher(token) {
    const url = `${URL_BASE}/Teacher/Delete`;

    try {
        const response = await fetch(url, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        });

        if (!response.ok) {
            throw new Error(`Error: ${response.statusText}`);
        }

        const data = await response.json();
        console.log('deleteTeacher:', data);
        return data;
    } catch (error) {
        console.error('Error fetching:', error);
    }
}

const email = 'daoblur.private@gmail.com';
const passwordHash = "XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg=";

login(email, passwordHash).then(data => {
    // Assignments Operations
    
    /*httpMethod
    (
        `${URL_BASE}/Assignment/Create`, 
        'POST', 
        data.token, 
        true,
        {
            title: 'BMI Calculator',
            courseId: "bf9ee4c7-b051-4dd8-ba56-101f2688888c",
            submissionDate: "2024-12-26T13:36:45.101Z"
        }, 
        'Assignment.Create'
    );*/

    /*httpMethod
    (
        `${URL_BASE}/Assignment/DolosAnalysis?assignmentId=`, 
        'POST', 
        data.token, 
        false,
        'e4be8d12-8d5e-43d2-817c-b5987043404d',
        'Assignment.DolosAnalysis'
    );*/
    
    httpMethod
    (
        `${URL_BASE}/Assignment/GetAllByCourseForTeacher?courseId=`, 
        'GET', 
        data.token, 
        false,
        '5500125e-16f5-4b77-9220-cc4dab69c100',
        'Assignment.GetAllByCourseForTeacher'
    );
}).catch(error => {
    console.error(error);
});