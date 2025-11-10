package com.huangyuan.goodsdomain.aggregate;

import java.io.Serializable;
import java.util.List;

public record ImageList(List<String> urls) implements Serializable {}
