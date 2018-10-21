package com.fh.entity.qizhe;

import org.junit.Test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TemplateProcess {


    /**
     * 审核项目抽取
     * @throws Exception
     */
    @Test
    public void test2() throws Exception {
        File file = new File("C:\\Users\\Administrator\\Desktop\\test\\template.html");
        BufferedReader br = new BufferedReader(new FileReader(file));
        String line = null;
        List<ProjectAudit> data = new ArrayList<>();
        List<String> strs = new ArrayList<>();
        while ((line = br.readLine()) != null) {
            if (line.contains("扣")) {
                String temp = line.substring(line.indexOf(">")+1, line.lastIndexOf("</"));
                String title = strs.get(strs.size() - 1);
                title = title.substring(title.indexOf(">")+1, title.lastIndexOf("</"));
                ProjectAudit projectAudit = new ProjectAudit();
                projectAudit.setName(title);
                projectAudit.setInfo(temp);
                data.add(projectAudit);
            }
            strs.add(line);
        }
        String str = "PROJECT_INFO.put(\"{0}\", \"{1}\");";
        for (ProjectAudit audit : data) {
            String template = MessageFormat.format(str, audit.getName(), audit.getInfo());
            System.out.println(template);
        }



    }


    @Test
    public void test3() throws Exception {
        File file = new File("/Users/cc/work/baiwenbo/template");
        BufferedReader br = new BufferedReader(new FileReader(file));
        String line = null;
        List<ProjectAudit> data = new ArrayList<>();
        List<String> strs = new ArrayList<>();
        ProjectAudit projectAudit = null;
        while ((line = br.readLine()) != null) {

            if (line.contains("扣")) {
                int a = 1;
                String temp = line.substring(line.indexOf(">")+1, line.lastIndexOf("</"));
                String title = strs.get(strs.size() - 1);
                title = title.substring(title.indexOf(">")+1, title.lastIndexOf("</"));
                projectAudit = new ProjectAudit();
                projectAudit.setName(title);
                projectAudit.setInfo(temp);
            }

            if (line.contains("</tr>")) {
                String temp = strs.get(strs.size()-1);
                if (temp.contains("<td align=\"left\" valign=\"top\">")) {
                    String help = temp.substring(temp.indexOf(">") + 1, temp.lastIndexOf("</"));
                    projectAudit.setHelp(help);
                    data.add(projectAudit);

                }
            }
            strs.add(line);
        }
        String str = "PROJECT_HELP.put(\"{0}\", \"{1}\");";
        for (ProjectAudit audit : data) {
            String template = MessageFormat.format(str, audit.getName().toLowerCase(), audit.getHelp());
            System.out.println(template);
        }



    }

    @Test
    public void test() throws Exception {
        File file = new File("/Users/cc/work/baiwenbo/template");
        BufferedReader br = new BufferedReader(new FileReader(file));
        String line = null;
        List<String> strs = new ArrayList<>();
        while ((line = br.readLine()) != null ) {
            if (line.indexOf("</tr>") > 0) {
                try {
                    String temp = strs.get(strs.size()-6);
                    temp = temp.substring(temp.indexOf("top\">") + 5, temp.indexOf("</td>"));

                    System.out.println(temp);

                    String stsTemp = strs.get(strs.size()-1);
                    strs.remove(strs.size()-1);
                    strs.addAll(t2(temp));
                    strs.add(stsTemp);

                } catch (Exception e) {
                    System.out.println("error");
                }

            }
            strs.add(line);
        }

        for(String s : strs) {
            System.out.println(s);
        }

    }

    public List<String>  t2(String num) {
        String s1 = "<td>";
        String s2 = "\t<c:choose>";
        String s3 = "\t\t<c:when test=\"${auditInfo['" + num + "'] == null}\">";
        String s4 = "\t\t\t<a class=\"btn btn-small btn-purple\" onclick=\"audit('${pd.ID}', '" + num + "', '')\">申诉</a>";
        String s5 = "\t\t</c:when>";
        String s5a = "<c:when test=\"${auditInfo['"+num+"'].status == 1 || auditInfo['"+num+"'].status == 3}\">";
        String s5b = "\t\t\t<a class=\"btn btn-small btn-danger\" onclick=\"audit('${pd.ID}', '"+num+"', ${auditInfo['"+num+"'].id})\">申诉回复</a>";
        String s5c = "\t\t</c:when>";
        String s6 = "\t\t<c:otherwise>";
        String s6a = "<a class=\"btn btn-small btn-purple\" onclick=\"audit('${pd.ID}', '"+num+"', '')\">再次申诉</a>";
        String s6b = "<a class=\"btn btn-small btn-warning\" onclick=\"audit('${pd.ID}', '" +num+"', ${auditInfo['"+num+"'].id})\">查看申诉</a>";
        String s9 = "\t\t</c:otherwise>";
        String s10 = "\t</c:choose>";
        String s11 = "</td>";
        String s12 = "</c:if>";
        List<String> sts = new ArrayList<>();
        sts.add("<%--代码生成器生成 开始--%>");
        sts.add("<c:if test=\"${pd.ID != null}\"><td>");
        sts.add("<a class=\"btn btn-small btn-success\" onclick=\"addImage('${pd.ID}', '" + num + "')\">上传图片</a>");
        sts.add("<a class=\"btn btn-small btn-info\" onclick=\"imageDeal('${pd.ID}', '" + num +"')\">查看图片</a></td>");
        sts.add(s1);
        sts.add(s2);
        sts.add(s3);
        sts.add(s4);
        sts.add(s5);
        sts.add(s5a);
        sts.add(s5b);
        sts.add(s5c);
        sts.add(s6);
        sts.add(s6a);
        sts.add(s6b);
        sts.add(s9);
        sts.add(s10);
        sts.add(s11);
        sts.add(s12);
        sts.add("<%--代码生成器生成 结束--%>");
        return sts;

    }
}
