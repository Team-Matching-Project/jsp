package dto;

/**
 * ProjectDTO 클래스
 * - PROJECT 테이블의 데이터를 담는 '바구니' (Data Transfer Object)
 * - JSP 페이지 간에 프로젝트 정보를 전달할 때 사용됩니다.
 */
public class ProjectDTO {

	// 1. 필드 (DB 테이블의 컬럼명과 일치시키는 것이 좋음)
	private int projectID;
	private String projectTitle;
	private String projectType;
	private String projectDuration;
	private String techStacks;
	private String projectDescription;
	private String deadline;          // 날짜도 String으로 처리하는 것이 JSP에서 편할 수 있습니다.
	private int totalMembers;
	private int currentMembers;       // 현재 모집된 인원 (DB에서 계산 또는 저장)
	private String status;            // (모집 중, 모집 완료)
	private String leaderID;          // 작성자 (FK, USER 테이블의 userID)
	private String createDate;        // 작성일

	// 2. 기본 생성자 (필수)
	public ProjectDTO() {}

	// 3. Getters and Setters (모든 필드에 대해 생성)
	// (Eclipse: Source -> Generate Getters and Setters...)
	
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
}