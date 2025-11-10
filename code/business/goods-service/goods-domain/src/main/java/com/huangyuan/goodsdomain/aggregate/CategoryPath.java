package com.huangyuan.goodsdomain.aggregate;

import java.io.Serializable;

public record CategoryPath(Integer oneId, Integer twoId, Integer threeId) implements Serializable {}
