# coding=utf-8
# Create your views here.
from django.http import HttpResponse
from django.shortcuts import render_to_response,render,HttpResponseRedirect
import models
from django.template import RequestContext,Context,Template
from django.shortcuts import redirect
from django.core.paginator import Paginator
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth.models import AnonymousUser
import urllib2

def logout(request):   
    request.session['user'] = AnonymousUser()
    return render_to_response("login.html",{},context_instance = RequestContext(request))
def login(request):   
    if request.REQUEST.has_key('userName') and request.REQUEST.has_key('userPsd'):
        userName1 = request.REQUEST['userName']
        userPsd1  = request.REQUEST['userPsd']
        try:
            user1 = models.user_info.objects.get(userName=userName1,userPsd=userPsd1)
            request.user = user1
            request.session['user'] = user1
            ## send msg to erl site server
            response = urllib2.urlopen('http://127.0.0.1:8442/?userid='+str(user1.userId)+'&username='+str(user1.userName)+'&userip='+str(get_client_ip(request))+'&comm=0')
            html = response.read()
            if request.user.userType==1:
                return redirect("/classinfo")
            elif request.user.userType==2:
                return render_to_response("index_t.html",{"user":request.user},context_instance = RequestContext(request))
            elif request.user.userType==3:
                return render_to_response("addT.html",{"user":request.user},context_instance = RequestContext(request))              
        except ObjectDoesNotExist:
            return render_to_response("login.html",{"tip":"用户验证失败"},context_instance = RequestContext(request))
    else:
        return render_to_response("login.html",{},context_instance = RequestContext(request))
        
def sreg(request):
    if request.REQUEST.has_key('userName') and request.REQUEST.has_key('userPsd'):
        try:
            user1 = models.user_info.objects.create(userName=request.REQUEST['userName']
            ,userPsd=request.REQUEST['userPsd']
            ,userType=1)
            request.user = user1
            return redirect("/?userName="+request.REQUEST['userName']+"&userPsd="+request.REQUEST['userPsd']
                                      , status=200)
        except:
            return HttpResponse(u'用户名已被注册<a href="/sreg">点我返回</a>', status=404)
    else:
        return render_to_response("sreg.html",{},context_instance = RequestContext(request))
     

def addT(request): 
    if request.REQUEST.has_key('userName') and request.REQUEST.has_key('userPsd') and request.session['user'].userType==3:
        try:
            user1 = models.user_info.objects.create(userName=request.REQUEST['userName']
                                                    ,userPsd=request.REQUEST['userPsd']
                                                    ,userType=2)

            return render_to_response("addT.html",{"user":request.user,'tip':'创建成功'},context_instance = RequestContext(request))
        except:
            return render_to_response("addT.html",{"user":request.user,'tip':'用户名已被注册'},context_instance = RequestContext(request))
    else:
        return render_to_response("addT.html",{"user":request.session['user']},context_instance = RequestContext(request))   
    
def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip