process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

async function login(email, passwordHash) {
    const url = 'https://localhost:9200/api/Student/LogIn';
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
    console.log(data);
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
async function joinToCourse(invitationId, studentId, token) {
    const url = `http://localhost:9100/api/Enrollment/Join/${invitationId}?studentId=${studentId}`;

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
const email = 'elmerson30@plagitracker.com';
const passwordHash = "XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg=";
const courseId = '5500125e-16f5-4b77-9220-cc4dab69c100';

login(email, passwordHash).then(data => {
    //return getAllByCourse(courseId, data.token);
    return joinToCourse(courseId, data.id, data.token);
}).then(data => {
    console.log('Assignments:', data);
}).catch(error => {
    console.error('Error:', error);
});

/*
getAllByCourseWithOutToken(courseId).then(data => {
    console.log('Assignments:', data);
}).catch(error => {
    console.error('Error:', error);
});
*/