package uniqueKey.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uniqueKey.model.UniqueKeyModel;
import uniqueKey.model.UniqueKeyTable;

/**
 * Servlet implementation class UniqueKeyController
 */
@WebServlet("/UniqueKeyController")
public class UniqueKeyController extends HttpServlet {
	private int i = 0;
	// private String previousKeys = "";

	private static final long serialVersionUID = 1L;

	private List<UniqueKeyTable> uniqueKeyTableList = new ArrayList<UniqueKeyTable>();

	private void addUniqueKeyTableData(String newGeneratedKey, String attemptNum, String timeTaken) {
		UniqueKeyTable uniqueVal = new UniqueKeyTable();

		uniqueVal.setNewGeneratedKey(newGeneratedKey);
		uniqueVal.setattemptNum(attemptNum);
		uniqueVal.settimeTaken(timeTaken);

		uniqueKeyTableList.add(uniqueVal);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		UniqueKeyModel uniqueKeyModel = new UniqueKeyModel();

		if (uniqueKeyModel.getKeyLength() == 0 || request.getParameter("uniqueKeyTextBox") == null
				|| request.getParameter("uniqueKeyTextBox").toString() == "") {
			uniqueKeyModel.setKeyLength(16);
		} else {
			uniqueKeyModel.setKeyLength(Integer.parseInt(request.getParameter("keyLeangthTextBox")));
		}

		session.setAttribute("uniqueKeyModel", uniqueKeyModel);
		session.setAttribute("uniqueKeyTableList", uniqueKeyTableList);

		if (request.getParameter("generateKeyButton") != null) {
			try {
				long startTime = System.nanoTime();

				// Set Key Length
				uniqueKeyModel.setKeyLength(Integer.parseInt(request.getParameter("keyLeangthTextBox")));

				// Generate new Key
				uniqueKeyModel.setNewGeneratedKey(
						GenerateNewRandomKey(Integer.parseInt(request.getParameter("keyLeangthTextBox"))));

				long elapsedTime = System.nanoTime() - startTime;

				addUniqueKeyTableData(uniqueKeyModel.getNewGeneratedKey(), Integer.toString(i),
						Long.toString(elapsedTime / 1000000));
			} catch (Exception e) {
				uniqueKeyModel.setErrorMessage("Error while generating new key : " + e.getMessage());
			}

		}

		else if (request.getParameter("clearButton") != null) {
			uniqueKeyModel.setAllGeneratedKeys("");
			uniqueKeyModel.setKeyLength(16);
			uniqueKeyModel.setNewGeneratedKey("");
			i = 0;
			uniqueKeyTableList = new ArrayList<UniqueKeyTable>();
			session.setAttribute("uniqueKeyTableList", uniqueKeyTableList);
		}

		getServletContext().getRequestDispatcher("/Main.jsp").forward(request, response);

	}

	// Code referenced : https://www.geeksforgeeks.org/
	private String GenerateNewRandomKey(int keyLeangth) {
		i++;
		String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";

		StringBuilder sb = new StringBuilder(keyLeangth);

		for (int n = 0; n < keyLeangth; n++) {

			int index = (int) (AlphaNumericString.length() * Math.random());

			sb.append(AlphaNumericString.charAt(index));
		}

		return sb.toString();
	}

}
