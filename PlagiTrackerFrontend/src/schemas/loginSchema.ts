// utils/loginValidation.ts
import { z } from 'zod'

export const loginSchema = z.object({
  email: z
    .string()
    .min(1, { message: 'Email is required.' }) // Validación de email requerido
    .email({ message: 'Invalid email address.' }),
  password: z.string().min(1, { message: 'Password is required.' })
})
