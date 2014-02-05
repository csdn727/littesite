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

def dictfetchall(cursor):
    "Returns all rows from a cursor as a dict"
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]

def cinfo(request):   
    if request.session['user'].is_authenticated() == True and request.session['user'].userType==1:
        cursor = connection.cursor()
        cursor.execute('''SELECT `class_info`.`classId`,`class_info`.`className`,`class_info`.`classDesc`
        ,`class_info`.`classMax`,`class_info`.`classT`,
        MAX( CASE when `class_reg`.`userId` = %s then 1 else 0 END ) AS is_picked
        FROM `class_info` LEFT JOIN `class_reg` ON `class_info`.`classId`=`class_reg`.`classId` 
        GROUP BY `class_info`.`classId`,`class_info`.`className`,`class_info`.`classDesc`,`class_info`.`classMax`,`class_info`.`classT`;'''
        ,str(request.session['user'].userId))
        return render_to_response("classinfo.html",{"user":request.session['user'],'classes':dictfetchall(cursor)},context_instance = RequestContext(request))
    else:
        return HttpResponse(u'禁止访问', status=404)    

def classList(request):   
    if request.session['user'].is_authenticated() == True and request.session['user'].userType==2:
        classes = models.class_info.objects.all()
        return render_to_response("classList.html",{"user":request.session['user'],'classes':classes},context_instance = RequestContext(request))
    else:
        return HttpResponse(u'禁止访问', status=404)       

def newClass(request):   
    if request.session['user'].is_authenticated() == True and request.session['user'].userType==2:
        if request.REQUEST.has_key('classname') and request.REQUEST.has_key('classdesc') and request.REQUEST.has_key('classmax') and request.REQUEST.has_key('classt'):
            try:
                models.class_info.objects.create(className=request.REQUEST['classname'],
                                             classDesc=request.REQUEST['classdesc'],
                                             classMax =request.REQUEST['classmax'],
                                             classT   =request.REQUEST['classt'])
            except:
                pass
            finally:
                return redirect("/classList")
        return render_to_response("newclass.html",{"user":request.session['user'],'tip':'请正确填写参数'},context_instance = RequestContext(request))
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