
# libfont
通过汉字点阵字库实现字符串的点阵字库生成  

# 实现基础
* 1，用点整字库分别生成16及12号字体大小的中英文字库文件"*.hzk"  
* 2，通过查找点阵字库得到对应字符的点阵数据，然后转换成制定的bitmap格式数据，目前支持ARGB1555  
* 3，字体大小目前支持12/16的整数倍，大于16号字体时是用12/16进行整数倍放大方法实现  

# TEST
* make  
* ./test_hzk_font  
