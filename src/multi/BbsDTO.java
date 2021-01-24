package multi;
//게시판 관리(DataRoom DTO 참조)
public class BbsDTO {
	/*
	회원테이블과 join하여 이름을 가져오기 위해 DTO클래스에
	name컬럼을 추가한다. 
	 */
	private int num;//일련번호
	private String id;//작성자아이디(member테이블 참조)
	private String name;//join을 위한 name생성
	private String title;//제목
	private String content;//내용
	private java.sql.Date postdate;//작성일
	private String attachedfile;
	private String changefile;
	private int downcount;
	private int visitcount;//조회수
	private String flag;//게시판 구별
	private String cal;//캘린더 날짜구별
	
	public String getCal() {
		return cal;
	}
	public void setCal(String cal) {
		this.cal = cal;
	}
	public String getChangefile() {
		return changefile;
	}
	public void setChangefile(String changefile) {
		this.changefile = changefile;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public int getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(int visitcount) {
		this.visitcount = visitcount;
	}
	public String getAttachedfile() {
		return attachedfile;
	}
	public void setAttachedfile(String attachedfile) {
		this.attachedfile = attachedfile;
	}
	public int getDowncount() {
		return downcount;
	}
	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}

}
