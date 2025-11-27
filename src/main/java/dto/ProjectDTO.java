package dto;

public class ProjectDTO {

	private int projectID;
	private String projectTitle;
	private String projectType;
	private String projectDuration;
	private String techStacks;
	private String projectDescription;
	private String deadline;         
	private int totalMembers;
	private int currentMembers;
	private String status;
	private String leaderID;   
	private String createDate;
	private String requiredRoles;
	private String department;

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public ProjectDTO() {}

	
	public int getProjectID() {
		return projectID;
	}
	public void setProjectID(int projectID) {
		this.projectID = projectID;
	}
	public String getProjectTitle() {
		return projectTitle;
	}
	public void setProjectTitle(String projectTitle) {
		this.projectTitle = projectTitle;
	}
	public String getProjectType() {
		return projectType;
	}
	public void setProjectType(String projectType) {
		this.projectType = projectType;
	}
	public String getProjectDuration() {
		return projectDuration;
	}
	public void setProjectDuration(String projectDuration) {
		this.projectDuration = projectDuration;
	}
	public String getTechStacks() {
		return techStacks;
	}
	public void setTechStacks(String techStacks) {
		this.techStacks = techStacks;
	}
	public String getProjectDescription() {
		return projectDescription;
	}
	public void setProjectDescription(String projectDescription) {
		this.projectDescription = projectDescription;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public int getTotalMembers() {
		return totalMembers;
	}
	public void setTotalMembers(int totalMembers) {
		this.totalMembers = totalMembers;
	}
	public int getCurrentMembers() {
		return currentMembers;
	}
	public void setCurrentMembers(int currentMembers) {
		this.currentMembers = currentMembers;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLeaderID() {
		return leaderID;
	}
	public void setLeaderID(String leaderID) {
		this.leaderID = leaderID;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public String getRequiredRoles() {
	    return requiredRoles;
	}
	public void setRequiredRoles(String requiredRoles) {
	    this.requiredRoles = requiredRoles;
	}
}