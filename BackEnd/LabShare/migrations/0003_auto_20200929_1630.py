# Generated by Django 3.1 on 2020-09-29 16:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('LabShare', '0002_auto_20200929_0651'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='dob',
            field=models.DateTimeField(blank=True, default='2000-01-01'),
        ),
    ]