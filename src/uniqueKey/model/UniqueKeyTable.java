package uniqueKey.model;

public class UniqueKeyTable {
	private String newGeneratedKey;
	private String attemptNum;
	private String timeTaken; 

	public String gettimeTaken() {
		return timeTaken;
	}

	public void settimeTaken(String timeTaken) {
		this.timeTaken = timeTaken;
	}

	public String getattemptNum() {
		return attemptNum;
	}

	public void setattemptNum(String attemptNum) {
		this.attemptNum = attemptNum;
	}

	public String getNewGeneratedKey() {
		return newGeneratedKey;
	}
	
	public void setNewGeneratedKey(String newGeneratedKey)
	{
		this.newGeneratedKey = newGeneratedKey;
	}
	

}
