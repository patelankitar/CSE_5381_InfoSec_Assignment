package watermark.controller;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;

import java.io.IOException;
import java.io.InputStream;

import java.nio.file.Files;

import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import watermark.model.WaterMarkModel;

@WebServlet("/WaterMarkController")
@MultipartConfig
public class WaterMarkController extends HttpServlet {

	private static final long serialVersionUID = -20L;
	WaterMarkModel waterMarkModel = new WaterMarkModel();
	// private int counter = 0;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);

//		 String filename = request.getPathInfo().substring(1);
//	        File file = new File("/path/to/images", filename);
//	        response.setHeader("Content-Type", getServletContext().getMimeType(filename));
//	        response.setHeader("Content-Length", String.valueOf(file.length()));
//	        response.setHeader("Content-Disposition", "inline; filename=\"" + filename + "\"");
//	        Files.copy(file.toPath(), response.getOutputStream());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = (request).getSession();
		// waterMarkModel = (waterMarkModel) session.getAttribute("waterMarkModel");

		if (request.getParameter("backLabel") != null) {
			getServletContext().getRequestDispatcher("/Main.jsp").forward(request, response);
		}

		else {
			session.setAttribute("waterMarkModel", waterMarkModel);
			waterMarkModel.setErrorMessage("");

			// waterMarkModel.setTextToWatermark("Default Text");

			if (request.getParameter("submitButton") != null) {
				try {

					// String appPath = request.getServletContext().getRealPath("");

					if (waterMarkModel.getOriginalImgPath() == null || waterMarkModel.getOriginalImgPath() == "") {
						waterMarkModel.setErrorMessage("Please Browse and upload and image");
					} else {

						// String sourcePath =
						// "/Users/ankitapatel/eclipse-workspace/CSE_5381_InfoSec_Assignment/WebContent/img/Screenshot_Edited_new.png";
						// String targetPath =
						// "/Users/ankitapatel/eclipse-workspace/CSE_5381_InfoSec_Assignment/WebContent/img/Screenshot_Edited_new1.png";

						String sourcePath = waterMarkModel.getOriginalImgPath();
						String targetPath = getServletContext().getRealPath("//") + "img/WaterMarkedImage.png";

						// waterMarkModel.setWaterMarkedImgPath(targetPath);

						File sourceImageFile = new File(sourcePath);
						File destImageFile = new File(targetPath);

						waterMarkModel.setOriginalImgPath("img/UploadedImage.png");
						waterMarkModel.setWaterMarkedImgPath("img/WaterMarkedImage.png");

						String textToWaterMark = "Default Text";
						if (request.getParameter("waterMarkTextBox") != null) {
							textToWaterMark = request.getParameter("waterMarkTextBox").toString();
						}

						long startTime = System.nanoTime();

						addTextWatermark(textToWaterMark, sourceImageFile, destImageFile);

						// AnotherAddWatermarkMethod("Watermark Text", sourceImageFile, destImageFile);

						long elapsedTime = System.nanoTime() - startTime;

						waterMarkModel.setTimeTaken("Time Taken by process : " + Long.toString(elapsedTime / 1000000) + "ms");
						
						waterMarkModel.setImageUploadMessage("");
					}
				} catch (Exception e) {
					waterMarkModel.setErrorMessage("Error while adding water mark : " + e.getMessage());
				}

			} else if (request.getParameter("uploadImageButton") != null) {

				Part uploadedFile = request.getPart("uploadedFile");
				try (InputStream content = uploadedFile.getInputStream();) {

					// String appPath = request.getServletContext().getRealPath("");

					// String savePath = appPath + "img/" + "Screenshot_Edited_new_NowNew.png";

					// savePath =
					// "/Users/ankitapatel/eclipse-workspace/CSE_5381_InfoSec_Assignment/WebContent/img/Screenshot_Edited_new.png";

					// File file = new File(savePath);
					// Files.copy(content, file.toPath(), StandardCopyOption.REPLACE_EXISTING);

					// Files.copy(content, file.toPath(), StandardCopyOption.REPLACE_EXISTING);

					String savePath = getServletContext().getRealPath("//") + "img/UploadedImage.png";
					Files.copy(content, new File(savePath).toPath(), StandardCopyOption.REPLACE_EXISTING);

					waterMarkModel.setOriginalImgPath(savePath);
					waterMarkModel.setImageUploadMessage("Image Uploaded successfully");

				} catch (Exception e) {
					waterMarkModel.setErrorMessage("Error while uploading image  : " + e.getMessage());
				}
			} else if (request.getParameter("clearButton") != null) {
				waterMarkModel.setOriginalImgPath("");
				waterMarkModel.setErrorMessage("");
				waterMarkModel.setTextToWatermark("");
				waterMarkModel.setTimeTaken("");
				waterMarkModel.setWaterMarkedImgPath("");
				waterMarkModel.setImageUploadMessage("");

			}

			getServletContext().getRequestDispatcher("/Watermark.jsp").forward(request, response);
		}

	}

	protected void AnotherAddWatermarkMethod(String watermarkText, File sourceImageFile, File destImageFile) {

		// File origFile = new File("C:/OrignalImage.jpg");
		ImageIcon icon = new ImageIcon(sourceImageFile.getPath());

		// create BufferedImage object of same width and height as of original image
		BufferedImage sourceImage = new BufferedImage(icon.getIconWidth(), icon.getIconHeight(),
				BufferedImage.TYPE_INT_RGB);

		// create graphics object and add original image to it
		Graphics graphics = sourceImage.getGraphics();
		graphics.drawImage(icon.getImage(), 0, 0, null);

		graphics.setColor(Color.BLUE);
		graphics.setFont(new Font("Arial", Font.BOLD, 64));

		FontMetrics fontMetrics = graphics.getFontMetrics();
		Rectangle2D rect = fontMetrics.getStringBounds(watermarkText, graphics);

		int centerX = (icon.getIconWidth() - (int) rect.getWidth()) / 2;
		int centerY = icon.getIconHeight() / 2;

		graphics.drawString(watermarkText, centerX, centerY);
		graphics.dispose();

		try {
			ImageIO.write(sourceImage, "png", destImageFile);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	// Code ref. https://stackoverflow.com/
	protected static void addTextWatermark(String text, File sourceImageFile, File destImageFile) {
		try {
			BufferedImage sourceImage = ImageIO.read(sourceImageFile);
			Graphics2D g2d = (Graphics2D) sourceImage.getGraphics();

			AlphaComposite alphaChannel = AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 0.1f);
			g2d.setComposite(alphaChannel);
			g2d.setColor(Color.BLUE);
			g2d.setFont(new Font("Arial", Font.BOLD, 64));

			FontMetrics fontMetrics = g2d.getFontMetrics();
			Rectangle2D rect = fontMetrics.getStringBounds(text, g2d);

			// calculates the coordinate where the String is painted
			int centerX = (sourceImage.getWidth() - (int) rect.getWidth()) / 2;
			int centerY = sourceImage.getHeight() / 2;

			g2d.drawString(text, centerX, centerY);

			ImageIO.write(sourceImage, "png", destImageFile);
			g2d.dispose();

		} catch (IOException ex) {
			System.err.println(ex);
		}
	}

}
