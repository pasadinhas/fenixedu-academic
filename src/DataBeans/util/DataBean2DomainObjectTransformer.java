/*
 * Created on 2003/08/27
 *
 */
package DataBeans.util;

import org.apache.commons.lang.StringUtils;

import DataBeans.InfoObject;
import Dominio.IDomainObject;

/**
 * @author Luis Cruz    
 *
 */
public class DataBean2DomainObjectTransformer extends ObjectBeanTransformer
{

    /**
     * @param toClass
     * @param fromClass
     */
    public DataBean2DomainObjectTransformer()
    {
        super(IDomainObject.class, InfoObject.class);
    }

    /* (non-Javadoc)
     * @see dataBean.util.ObjectBeanTransformer#getHashKey(java.lang.Object)
     */
    protected Object getHashKey(Object fromObject)
    {
        return fromObject.getClass().getName() + ((InfoObject) fromObject).getIdInternal();
    }

    /* (non-Javadoc)
     * @see dataBean.util.ObjectBeanTransformer#destinationObjectConstructor(java.lang.Object)
     */
    protected Object destinationObjectConstructor(Object fromObject)
    {
        String classToCreate =
            InfoObject.class.getPackage().getName()
                + "."
                + StringUtils.stripStart(
                    fromObject.getClass().getName(),
                    fromObject.getClass().getPackage().getName() + ".Info");
        return objectConstructor(classToCreate);
    }

}