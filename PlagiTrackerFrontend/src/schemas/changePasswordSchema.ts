import { z } from 'zod'

// Creamos un esquema de validación con zod
const changePasswordSchema = z.object({
  email: z
    .string()
    .min(1, { message: 'Email is required' }) // Email es obligatorio
    .email({ message: 'Invalid email address.' })
    .max(50, { message: 'Email must not exceed 50 characters' })
    .refine(
      (email) => {
        // Este regex permite hasta dos extensiones
        const extensionCount = (email.match(/\./g) || []).length
        return extensionCount <= 2
      },
      { message: 'Email can only have up to two extensions.' }
    ),
  verificationCode: z
    .string() // Aceptamos como string para validar con regex
    .regex(/^\d+$/, 'Verification code must only contain numbers') // Verificar que solo contenga dígitos
    .min(1, 'Verification code is required') // El código de verificación es obligatorio
    .transform(Number), // Convertir a número
  newPasswordHash: z.string().min(8, 'Password must be at least 8 characters long') // Contraseña de mínimo 8 caracteres
})

// Exportar el esquema
export default changePasswordSchema
