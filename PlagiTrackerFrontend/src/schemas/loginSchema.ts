// utils/loginValidation.ts
import { z } from 'zod';

export const loginSchema = z.object({
  email: z
    .string()
    .min(1, { message: 'Email is required.' }) // Validación de email requerido
    .email({ message: 'Invalid email address.' })
    .refine((email) => {
      // Este regex permite hasta dos extensiones
      const extensionCount = (email.match(/\./g) || []).length;
      return extensionCount <= 2;
    }, { message: 'Email can only have up to two extensions.' }),

  password: z
    .string()
    .min(9, { message: 'Password must be at least 9 characters long.' }) // Cambiado a 9 para permitir contraseñas de mínimo 9 caracteres
    .max(30, { message: 'Password must not exceed 30 characters' })
});
