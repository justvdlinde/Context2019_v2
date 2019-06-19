using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;

namespace ServiceLocatorNamespace
{
    /// <summary>
    /// Class for keeping track of services, this way singletons aren't needed. 
    /// Creates a new service when it's needed but hasn't been created yet. 
    /// </summary>
    public class ServiceLocator
    {
        public static ServiceLocator Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new ServiceLocator();
                }
                return instance;
            }
        }
        private static ServiceLocator instance;

        public Dictionary<Type, IService> InstantiatedServices = new Dictionary<Type, IService>();

        public bool ContainsService<T>() where T : IService
        {
            return InstantiatedServices.ContainsKey(typeof(T));
        }

        public IService Get<T>() where T : IService
        {
            Type serviceType = typeof(T);

            if (InstantiatedServices.ContainsKey(serviceType))
            {
                return InstantiatedServices[serviceType];
            }
            else
            {
                if (serviceType.IsSubclassOf(typeof(MonoBehaviour)))
                {
                    return FindMonoServiceInScene(serviceType);
                }
                else
                {
                    return CreateNewServiceInstance(serviceType);
                }
            }
        }

        private IService FindMonoServiceInScene(Type serviceType)
        {
            Debug.LogWarning("This function is slow and is therefore best avoided. Please add the service using ServiceLocator.AddService on Awake and RemoveService on Destroy instead.");

            UnityEngine.Object service = UnityEngine.Object.FindObjectOfType(serviceType);
            if(service == null)
            {
                Debug.LogErrorFormat("Service of type {0} not found in scene ", serviceType);
                return null;
            }
            return service as IService;
        }

        private IService CreateNewServiceInstance(Type serviceType)
        {
            Debug.Log("creating new service instance of type " + serviceType.Name);

            IService service = (IService)Activator.CreateInstance(serviceType);
            AddService(service);

            return service;
        }

        public void AddService(IService service) 
        {
            if (!InstantiatedServices.ContainsKey(service.GetType()))
            {
                Debug.Log("Adding service of type" + service.ToString());
                InstantiatedServices.Add(service.GetType(), service);
            }
        }

        public void RemoveService(IService service) 
        {
            if (InstantiatedServices.ContainsKey(service.GetType()))
            {
                InstantiatedServices.Remove(service.GetType());
            }
        }
    }
}