// src/schemas/teacherSchema.ts
import { z } from 'zod'

// Crear el esquema de validación para Teacher
export const TeacherSchema = z.object({
  id: z.string().optional(), // El id es opcional
  firstName: z
    .string()
    .min(1, { message: 'First name is required' }) // Requerido y mínimo de 1 carácter
    .max(50, { message: 'First name must not exceed 50 characters' }), // Máximo de 50 caracteres
  lastName: z
    .string()
    .min(1, { message: 'Last name is required' }) // Requerido y mínimo de 1 carácter
    .max(50, { message: 'Last name must not exceed 50 characters' }), // Máximo de 50 caracteres

  email: z
    .string()
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
  passwordHash: z
    .string()
    .min(8, { message: 'Password is required and must be at least 8 characters long' }) // Mínimo de 8 caracteres
    .max(30, { message: 'Password must not exceed 30 characters' }) // Máximo de 30 caracteres
})

// Puedes usar el esquema para validar un objeto Teacher así:
export const validateTeacher = (data: unknown) => {
  return TeacherSchema.parse(data)
}
