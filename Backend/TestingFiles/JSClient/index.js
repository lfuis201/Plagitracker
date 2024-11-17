process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

async function login(email, passwordHash) {
    const url = 'https://localhost:9200/api/Teacher/LogIn';
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
    return data.token; // Asumiendo que el token se devuelve en un campo llamado 'token'
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
const email = 'mmarmol@gmail.com'; // Reemplaza con tu email
const passwordHash = "XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg="; // Reemplaza con tu hash de contraseña
const courseId = '5500125e-16f5-4b77-9220-cc4dab69c100'; // Reemplaza con el ID del curso

login(email, passwordHash).then(token => {
    console.log('Token JWT:', token);
    return getAllByCourse(courseId, token);
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