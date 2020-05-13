package uniqueKey.model;

public class UniqueKeyModel {
	private String newGeneratedKey;
	private String allGeneratedKeys;
	private int keyLength; 
	private String errorMessage;
	
	public int getKeyLength() {
		return keyLength;
	}

	public void setKeyLength(int keyLength) {
		this.keyLength = keyLength;
	}

	public String getAllGeneratedKeys() {
		return allGeneratedKeys;
	}

	public void setAllGeneratedKeys(String allGeneratedKeys) {
		this.allGeneratedKeys = allGeneratedKeys;
	}

	public String getNewGeneratedKey() {
		return newGeneratedKey;
	}
	
	public void setNewGeneratedKey(String newGeneratedKey)
	{
		this.newGeneratedKey = newGeneratedKey;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	
	
}
