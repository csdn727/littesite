from django.db import models

# Create your models here.
class class_info(models.Model):
    classId = models.AutoField('userId', primary_key=True)
    className = models.CharField('className', max_length=50, unique=True)
    classDesc = models.CharField('classDesc', max_length=200)
    classMax = models.IntegerField('classMax')
    classT = models.CharField('calssT', max_length=20)
    class Meta:
            db_table = 'class_info'     
    def __unicode__(self):
        return "%s" %self.className
class class_reg(models.Model):
    classId = models.IntegerField('classId')
    userId  = models.IntegerField('userId')
    userName= models.CharField('userName', max_length=50)
    className = models.CharField('className', max_length=50)
    class Meta:
            db_table = 'class_reg'     
    def __unicode__(self):
        return "%s" %self.className