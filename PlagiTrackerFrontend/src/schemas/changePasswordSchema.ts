import { z } from 'zod';

// Creamos un esquema de validación con zod
const changePasswordSchema = z.object({
  email: z.string().email('Invalid email').nonempty('Email is required'), // Email válido y obligatorio
  verificationCode: z.string() // Aceptamos como string para validar con regex
    .regex(/^\d+$/, 'Verification code must only contain numbers') // Verificar que solo contenga dígitos
    .nonempty('Verification code is required') // El código de verificación es obligatorio
    .transform(Number), // Convertir a número
  newPasswordHash: z.string().min(8, 'Password must be at least 8 characters long'), // Contraseña de mínimo 8 caracteres
});

// Exportar el esquema
export default changePasswordSchema;
