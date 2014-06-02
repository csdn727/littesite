# coding=utf-8
# Create your views here.
from django.db import connection
from django.http import HttpResponse
from django.shortcuts import render_to_response,render
import models 
from django.template import RequestContext,Context,Template
from django.shortcuts import redirect
from django.core.paginator import Paginator
from django.core.exceptions import ObjectDoesNotExist
import string

def dictfetchall(cursor):
    "Returns all rows from a cursor as a dict"
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]

def cinfo(request): 
    try:
        if request.session['user'].is_authenticated() == True and request.session['user'].userType==1:
            cursor = connection.cursor()
            cursor.execute('''SELECT `class_info`.`classId`,`class_info`.`className`,`class_info`.`classDesc`
            ,`class_info`.`classMax`,`class_info`.`classT`,`class_info`.`classPoint`,
            DATE_FORMAT(`class_info`.`classStart`,'%%Y-%%m-%%d') classStart,`class_info`.`classTimes`,
            MAX( CASE when `class_reg`.`userId` = %s then 1 else 0 END ) AS is_picked
            FROM `class_info` LEFT JOIN `class_reg` ON `class_info`.`classId`=`class_reg`.`classId` 
            GROUP BY `class_info`.`classId`,`class_info`.`className`,`class_info`.`classDesc`,`class_info`.`classMax`,`class_info`.`classT`;'''
            ,[str(request.session['user'].userId)])
            return render_to_response("classinfo.html",{"user":request.session['user'],'classes':dictfetchall(cursor)},context_instance = RequestContext(request))
        else:
            return HttpResponse(u'禁止访问', status=404)    
    except:
        return HttpResponse(u'禁止访问', status=404)

def classList(request):   
    if request.session['user'].is_authenticated() == True and request.session['user'].userType==2:
        classes = models.class_info.objects.all()
        return render_to_response("classList.html",{"user":request.session['user'],'classes':classes},context_instance = RequestContext(request))
    else:
        return HttpResponse(u'禁止访问', status=404)       

def newClass(request):   
    if request.session['user'].is_authenticated() == True and request.session['user'].userType==2:
        try:
            if request.REQUEST['classname'] == '' and len(request.REQUEST['classname'])>50:
                tip = '课程名错误'
            elif request.REQUEST['classdesc'] == '' and len(request.REQUEST['classname'])>200:
                tip = '课程简介错误'
            elif request.REQUEST['classmax'] == '':
                tip = '请填写课程人数限制'
            elif request.REQUEST['classt'] == '':
                tip = '请填写授课教师'   
            elif request.REQUEST['classPoint'] == '':
                tip = '请填写学分' 
            elif request.REQUEST['classTimes'] == '':
                tip = '请填写课时' 
            elif request.REQUEST['classStart'] == '':
                tip = '请填写开课时间' 
            else:
                tip = u'创建课程'+request.REQUEST['classname']+u'成功'
                models.class_info.objects.create(className=request.REQUEST['classname'],
                                            classDesc=request.REQUEST['classdesc'],
                                            classMax =int(request.REQUEST['classmax']),
                                            classT   =request.REQUEST['classt'],
                                            classPoint=string.atof(request.REQUEST['classPoint']),
                                            classTimes=request.REQUEST['classTimes'],
                                            classStart=request.REQUEST['classStart']+" 8:0:0"),  
            return render_to_response("newclass.html",{"user":request.session['user'],'tip':tip},context_instance = RequestContext(request))            
        except Exception, e:
            return render_to_response("newclass.html",{"user":request.session['user'],'tip':'请完整添加课程信息'+str(e)},context_instance = RequestContext(request))
    else:
        return HttpResponse(u'禁止访问', status=404)       
    
def classReg(request):   
    if request.session['user'].is_authenticated() == True and request.session['user'].userType==2 and request.REQUEST.has_key('classId'):
        classId1 = request.REQUEST['classId']
        selectedClass = models.class_reg.objects.filter(classId=classId1)
        return render_to_response("classreg.html",{"user":request.session['user'],'classes':selectedClass},context_instance = RequestContext(request))
    else:
        return HttpResponse(u'禁止访问', status=404) 
    
def index_t(request):   
    if request.session['user'].is_authenticated() == True and request.session['user'].userType==2:
        return render_to_response("index_t.html",{"user":request.session['user']},context_instance = RequestContext(request))