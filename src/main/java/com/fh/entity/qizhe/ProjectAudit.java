package com.fh.entity.qizhe;

public class ProjectAudit {

    private String name;

    private String info;

    private String help;

    public String getHelp() {
        return help;
    }

    public void setHelp(String help) {
        this.help = help;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    @Override
    public String toString() {
        return "ProjectAudit{" +
                "name='" + name + '\'' +
                ", info='" + info + '\'' +
                '}';
    }
}
