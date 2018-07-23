package com.snailclimb.bean;

public class ScoreResult {
	public int value; // 点赞数
	public String name;// 人名

	public float getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ScoreResult(int value, String name) {
		super();
		this.value = value;
		this.name = name;
	}

	@Override
	public String toString() {
		return "ScoreResult [value=" + value + ", name=" + name + "]";
	}

}
