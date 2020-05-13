package hash.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hash.model.HashModel;
import hash.model.HashedValuesTable;

@WebServlet("/HashController")
public class HashController extends HttpServlet {

	private static final long serialVersionUID = -20L;

	private List<HashedValuesTable> hashedValuesTableList = new ArrayList<HashedValuesTable>();

	private void addHashedValueTableData(String inputText1, String hashedValue1, String timeTaken) {

		HashedValuesTable hashVal = new HashedValuesTable();

		hashVal.setInputText(inputText1);
		hashVal.setHashedValue(hashedValue1);
		hashVal.setTimeTaken(timeTaken);

		hashedValuesTableList.add(hashVal);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		HashModel hashmodel = new HashModel();

		session.setAttribute("hashmodel", hashmodel);
		request.setAttribute("hashedValuesTableList", hashedValuesTableList);

		
		if (request.getParameter("generateHashButton") != null) {

			long startTime = System.nanoTime();
			hashmodel.setStringToHash(request.getParameter("stringToHashTextBox").toString());
			hashmodel.setHashedValue(getMd5(request.getParameter("stringToHashTextBox").toString()));
			long elapsedTime = System.nanoTime() - startTime;

			addHashedValueTableData(hashmodel.getStringToHash(), hashmodel.getHashedValue(),
					Long.toString(elapsedTime / 1000000));

		} else if (request.getParameter("clearButton") != null) {
			hashmodel.setHashedValue("");
			hashmodel.setStringToHash("");
			hashedValuesTableList = new ArrayList<HashedValuesTable>();
		} 
		
		else {
			hashmodel.setStringToHash("Default Value");
			hashmodel.setHashedValue("Default Value");
		}
		
		
		
		getServletContext().getRequestDispatcher("/Hash.jsp").forward(request, response);
	}

	// Note : Code referenced from https://www.geeksforgeeks.org/
	public static String getMd5(String input) {
		try {

			// Static getInstance method is called with hashing MD5
			MessageDigest md = MessageDigest.getInstance("MD5");

			// digest() method is called to calculate message digest
			// of an input digest() return array of byte
			byte[] messageDigest = md.digest(input.getBytes());

			// Convert byte array into signum representation
			BigInteger no = new BigInteger(1, messageDigest);

			// Convert message digest into hex value
			String hashtext = no.toString(16);
			while (hashtext.length() < 32) {
				hashtext = "0" + hashtext;
			}
			return hashtext;
		}

		// For specifying wrong message digest algorithms
		catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e);
		}
	}
}