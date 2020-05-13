package encryption.controller;

import java.io.IOException;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import encryption.model.EncryptionModel;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

import java.util.Base64;

@WebServlet("/EncryptionController")
@MultipartConfig
public class EncryptionController extends HttpServlet {

	private static final long serialVersionUID = -20L;
	EncryptionModel encryptionModel = new EncryptionModel();

	private static SecretKeySpec secretKey;
	private static byte[] key;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = (request).getSession();

		session.setAttribute("encryptionModel", encryptionModel);
		encryptionModel.setErrorMessage("");

		// Encoding
		if (request.getParameter("encryptButton") != null) 
		{
			
			if (request.getParameter("inputPlainTextBox") != null && request.getParameter("inputPlainTextBox").toString() != "" &&
					!request.getParameter("inputPlainTextBox").toString().isEmpty()) 
			{
				if (request.getParameter("keyTextBox") != null && request.getParameter("keyTextBox").toString() != null && 
						request.getParameter("keyTextBox").toString() != "" && !request.getParameter("keyTextBox").toString().isEmpty()) 
				{
					System.out.println("on blank = " + request.getParameter("keyTextBox").toString());
					
					encryptionModel.setInputPlainText(request.getParameter("inputPlainTextBox").toString());
					encryptionModel.setKey(request.getParameter("keyTextBox").toString());

					// code ref. from stackoverflow

					try 
					{
						//System.out.println("encryptionModel.getInputPlainText() = " +encryptionModel.getInputPlainText());
						
						String encrypted = DoEncryption(encryptionModel.getInputPlainText(), encryptionModel.getKey());
						encryptionModel.setGeneratedCipherText(encrypted.toString());
						
						//System.out.println("encryptionModel.getGeneratedCipherText() = " + encryptionModel.getGeneratedCipherText());
					}
					catch (Exception e) {
						encryptionModel.setErrorMessage("Error while encrypting : " + e.toString());
					}

				} 
				else 
				{
					encryptionModel.setErrorMessage("Please provide Key to encypt text");
				}
			} 
			else
			{
				encryptionModel.setErrorMessage("Please provide plain text to generate encrypted text");
			}

		}
		// Decoding
		else if (request.getParameter("decryptButton") != null)
		{
			if (request.getParameter("inputCipherTextBox") != null && request.getParameter("inputCipherTextBox").toString() != ""
					&& !request.getParameter("inputCipherTextBox").toString().isEmpty()) 
			{

				if (request.getParameter("keyTextBox") != null && request.getParameter("keyTextBox").toString() != ""
						&& !request.getParameter("keyTextBox").toString().isEmpty()) 
				{
					encryptionModel.setInputCipherText(request.getParameter("inputCipherTextBox").toString());
					encryptionModel.setKey(request.getParameter("keyTextBox").toString());

					// code ref. from stackoverflow

					try 
					{
						//System.out.println("encryptionModel.getInputCipherText() = " + encryptionModel.getInputCipherText());
						
						String decrypted = DoDecryption(encryptionModel.getInputCipherText(), encryptionModel.getKey());
						//System.out.println("16 : = " + decrypted);
						
						encryptionModel.setGeneratedPlainText(decrypted);
						
						//System.out.println("encryptionModel.getGeneratedPlainText() = " + encryptionModel.getGeneratedPlainText());
						
					}
					catch (Exception e) {
						encryptionModel.setErrorMessage("Error while encrypting : " + e.toString());
					}

				} 
				else 
				{
					encryptionModel.setErrorMessage("Please provide Key to encypt text");
				}
			} 
			else
			{
				encryptionModel.setErrorMessage("Please provide cipher text to generate original text");
			}

		}
		
		// Clear values
		else if (request.getParameter("clearButton") != null) 
		{
			encryptionModel.setErrorMessage("");
			encryptionModel.setGeneratedCipherText("");
			encryptionModel.setGeneratedPlainText("");
			encryptionModel.setInputCipherText("");
			encryptionModel.setInputPlainText("");
			encryptionModel.setKey("");
			
			encryptionModel = new EncryptionModel();
			session.setAttribute("encryptionModel", encryptionModel);
			
		}

		getServletContext().getRequestDispatcher("/Encryption.jsp").forward(request, response);
	}

	protected String DoEncryption(String plainText, String key) {
		setKey(key);
		try
        {
            setKey(key);
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            return Base64.getEncoder().encodeToString(cipher.doFinal(plainText.getBytes("UTF-8")));
        } 
        catch (Exception e) 
        {
            System.out.println("Error while encrypting: " + e.toString());
        }
        return null;
	}
	
	protected String DoDecryption(String cipherText, String key) {
		try
        {	
            setKey(key);
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            return new String(cipher.doFinal(Base64.getDecoder().decode(cipherText)));
        } 
        catch (Exception e) 
        {
        	System.out.println("5");
			System.out.println("Error while decrypting: " + e.toString());
        }
        return null;
	}

	public static void setKey(String myKey) {
		MessageDigest sha = null;
		try {
			key = myKey.getBytes("UTF-8");
			sha = MessageDigest.getInstance("SHA-1");
			key = sha.digest(key);
			key = Arrays.copyOf(key, 16);
			secretKey = new SecretKeySpec(key, "AES");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
}
