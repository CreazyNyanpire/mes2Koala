package org.seu.acetec.mes2Koala.facade.dto;

import java.util.Date;

import org.seu.acetec.mes2Koala.core.domain.FTLot;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;

public class FTLotOptionLogDTO implements Serializable {

	private Long id;

	private int version;

	private String optType;

	private String flownow;

	private String lastModifyEmployNo;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date createTimestamp;

	private Date createTimestampEnd;

	private String createEmployNo;

	private String remark;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date lastModifyTimestamp;

	private Date lastModifyTimestampEnd;

	private FTLotDTO ftLotDTO;

	private Integer logic;
	
	private Long internalLotId;

	public void setOptType(String optType) {
		this.optType = optType;
	}

	public String getOptType() {
		return this.optType;
	}

	public void setFlownow(String flownow) {
		this.flownow = flownow;
	}

	public String getFlownow() {
		return this.flownow;
	}

	public void setLastModifyEmployNo(String lastModifyEmployNo) {
		this.lastModifyEmployNo = lastModifyEmployNo;
	}

	public String getLastModifyEmployNo() {
		return this.lastModifyEmployNo;
	}

	public void setCreateTimestamp(Date createTimestamp) {
		this.createTimestamp = createTimestamp;
	}

	public Date getCreateTimestamp() {
		return this.createTimestamp;
	}

	public void setCreateTimestampEnd(Date createTimestampEnd) {
		this.createTimestampEnd = createTimestampEnd;
	}

	public Date getCreateTimestampEnd() {
		return this.createTimestampEnd;
	}

	public void setCreateEmployNo(String createEmployNo) {
		this.createEmployNo = createEmployNo;
	}

	public String getCreateEmployNo() {
		return this.createEmployNo;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setLastModifyTimestamp(Date lastModifyTimestamp) {
		this.lastModifyTimestamp = lastModifyTimestamp;
	}

	public Date getLastModifyTimestamp() {
		return this.lastModifyTimestamp;
	}

	public void setLastModifyTimestampEnd(Date lastModifyTimestampEnd) {
		this.lastModifyTimestampEnd = lastModifyTimestampEnd;
	}

	public Date getLastModifyTimestampEnd() {
		return this.lastModifyTimestampEnd;
	}

	public void setFtLotDTO(FTLotDTO ftLotDTO) {
		this.ftLotDTO = ftLotDTO;
	}

	public FTLotDTO getFtLotDTO() {
		return this.ftLotDTO;
	}

	public void setLogic(Integer logic) {
		this.logic = logic;
	}

	public Integer getLogic() {
		return this.logic;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public Long getInternalLotId() {
		return internalLotId;
	}

	public void setInternalLotId(Long internalLotId) {
		this.internalLotId = internalLotId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		FTLotOptionLogDTO other = (FTLotOptionLogDTO) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}