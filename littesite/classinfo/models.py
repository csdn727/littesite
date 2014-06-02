# coding=utf-8
from django.db import models

# Create your models here.
class class_info(models.Model):
    classId = models.AutoField('userId', primary_key=True)
    className = models.CharField('className', max_length=50, unique=True)
    classDesc = models.CharField('classDesc', max_length=200)
    classMax = models.DecimalField('classMax', max_digits=11, decimal_places=1)
    classPoint = models.IntegerField('classPoint')
    classStart = models.DateTimeField('classStart')
    classTimes = models.IntegerField('classTimes')
    classT = models.CharField('calssT', max_length=20)
    class Meta:
            db_table = 'class_info'     
    def __unicode__(self):
        return u"课程名:%s 课时:%s" %(self.className,self.classTimes)
class class_reg(models.Model):
    classId = models.IntegerField('classId')
    userId  = models.IntegerField('userId')
    userName= models.CharField('userName', max_length=50)
    className = models.CharField('className', max_length=50)
    class Meta:
            db_table = 'class_reg'     
    def __unicode__(self):
        return "%s" %self.className