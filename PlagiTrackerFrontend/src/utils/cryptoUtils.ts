// src/utils/cryptoUtils.ts
import CryptoJS from 'crypto-js';

// Accede a las variables de entorno
const plagiTrackerSecretKey = CryptoJS.enc.Utf8.parse(process.env.PLAGITRACKER_ENCRYPT_KEY || ''); // 16 bytes para AES-128
const plagiTrackerIV = CryptoJS.enc.Utf8.parse(process.env.PLAGITRACKER_IV || ''); // 16 bytes

// Función para cifrar texto
export const encrypt = (text: string): string => {
  const encrypted = CryptoJS.AES.encrypt(text, plagiTrackerSecretKey, { iv: plagiTrackerIV });
  return encrypted.toString(); // Devuelve como una cadena
};

// Función para descifrar texto
export const decrypt = (ciphertext: string): string => {
  try {
    const bytes = CryptoJS.AES.decrypt(ciphertext, plagiTrackerSecretKey, { iv: plagiTrackerIV });
    const decrypted = bytes.toString(CryptoJS.enc.Utf8);

    // Verificar si el texto descifrado está vacío
    if (decrypted === '' && bytes.toString() !== '') {
      throw new Error('Decryption failed: result is empty');
    }

    return decrypted;
  } catch (error) {
    console.error('Decryption error:', error.message);
    return '';
  }
};
