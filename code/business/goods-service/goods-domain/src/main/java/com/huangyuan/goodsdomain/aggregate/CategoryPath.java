package com.huangyuan.goodsdomain.aggregate;

import java.io.Serializable;

public record CategoryPath(Integer oneId, Integer twoId, Integer threeId) implements Serializable {
    public boolean isValid() {
        return oneId == null || twoId == null || threeId == null;
    }
}
